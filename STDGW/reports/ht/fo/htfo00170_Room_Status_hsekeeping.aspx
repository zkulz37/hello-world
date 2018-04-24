<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_print_date="";
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00170_hse_kping");
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	DataTable dt2 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00170_hse_kping2");
    if (dt2.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="htfo00170_Room_Status_hsekeeping_files/filelist.xml">
<link rel=Edit-Time-Data
href="htfo00170_Room_Status_hsekeeping_files/editdata.mso">
<link rel=OLE-Object-Data
href="htfo00170_Room_Status_hsekeeping_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ks</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-21T08:25:15Z</o:LastPrinted>
  <o:Created>2006-06-10T10:41:35Z</o:Created>
  <o:LastSaved>2010-12-22T03:10:45Z</o:LastSaved>
  <o:Company>Hotel</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .16in .21in .24in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:136;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:136;
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
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:purple;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl80
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl99
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	color:purple;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	color:green;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl103
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-rotate:90;}
.xl115
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-rotate:90;}
.xl116
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-rotate:88;}
.xl117
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-rotate:88;}
.xl118
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-rotate:90;}
.xl119
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl120
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	color:#003366;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	background:white;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl126
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl127
	{mso-style-parent:style0;
	color:#333333;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl133
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl135
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl136
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl137
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl138
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	border:.5pt solid windowtext;}
.xl139
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl143
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl144
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl145
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	color:#333333;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	color:#333300;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl149
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl150
	{mso-style-parent:style0;
	color:green;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl151
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl152
	{mso-style-parent:style0;
	color:purple;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl153
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl154
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl155
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl156
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl157
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl158
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-rotate:90;}
.xl159
	{mso-style-parent:style0;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl161
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl162
	{mso-style-parent:style0;
	color:purple;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl163
	{mso-style-parent:style0;
	color:purple;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl165
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl166
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl167
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl168
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl169
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl170
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl171
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl176
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style0;
	color:#3366ff;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl179
	{mso-style-parent:style0;
	color:#E9D711;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl180
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl183
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl184
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl187
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"General Date";
	text-align:left;
	vertical-align:middle;}
.xl188
	{mso-style-parent:style0;
	color:#ff0000;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl189
	{mso-style-parent:style0;
	color:#0BC02C;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl190
	{mso-style-parent:style0;
	color:#ff6600;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl191
	{mso-style-parent:style0;
	color:blue;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl192
	{mso-style-parent:style0;
	color:teal;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl193
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl194
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl195
	{mso-style-parent:style0;
	color:fuchsia;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl196
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl197
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl198
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl199
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl200
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl201
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl202
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Report</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>27</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7035</x:WindowHeight>
  <x:WindowWidth>11925</x:WindowWidth>
  <x:WindowTopX>15</x:WindowTopX>
  <x:WindowTopY>-270</x:WindowTopY>
  <x:TabRatio>601</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Report!$A$1:$Z$20</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4725 style='border-collapse:
 collapse;table-layout:fixed;width:3548pt'>
 <col class=xl66 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col class=xl66 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl66 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col class=xl66 width=37 span=2 style='mso-width-source:userset;mso-width-alt:
 1184;width:28pt'>
 <col class=xl66 width=39 style='mso-width-source:userset;mso-width-alt:1248;
 width:29pt'>
 <col class=xl65 width=39 style='mso-width-source:userset;mso-width-alt:1248;
 width:29pt'>
 <col class=xl66 width=37 style='mso-width-source:userset;mso-width-alt:1184;
 width:28pt'>
 <col class=xl66 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl66 width=37 style='mso-width-source:userset;mso-width-alt:1184;
 width:28pt'>
 <col class=xl66 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl66 width=39 style='mso-width-source:userset;mso-width-alt:1248;
 width:29pt'>
 <col class=xl66 width=46 style='mso-width-source:userset;mso-width-alt:1472;
 width:35pt'>
 <col class=xl66 width=47 style='mso-width-source:userset;mso-width-alt:1504;
 width:35pt'>
 <col class=xl66 width=42 style='mso-width-source:userset;mso-width-alt:1344;
 width:32pt'>
 <col class=xl66 width=40 span=2 style='mso-width-source:userset;mso-width-alt:
 1280;width:30pt'>
 <col class=xl66 width=38 style='mso-width-source:userset;mso-width-alt:1216;
 width:29pt'>
 <col class=xl66 width=14 style='mso-width-source:userset;mso-width-alt:448;
 width:11pt'>
 <col class=xl66 width=66 style='mso-width-source:userset;mso-width-alt:2112;
 width:50pt'>
 <col class=xl66 width=46 style='mso-width-source:userset;mso-width-alt:1472;
 width:35pt'>
 <col class=xl66 width=53 style='mso-width-source:userset;mso-width-alt:1696;
 width:40pt'>
 <col class=xl66 width=43 style='mso-width-source:userset;mso-width-alt:1376;
 width:32pt'>
 <col class=xl66 width=36 style='mso-width-source:userset;mso-width-alt:1152;
 width:27pt'>
 <col class=xl66 width=32 style='mso-width-source:userset;mso-width-alt:1024;
 width:24pt'>
 <col class=xl66 width=51 style='mso-width-source:userset;mso-width-alt:1632;
 width:38pt'>
 <col class=xl66 width=72 span=51 style='width:54pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 width=40 style='height:23.25pt;width:30pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:0;width:217.5pt;height:78pt;z-index:1'>
   <v:imagedata src="htfo00170_Room_Status_hsekeeping_files/image001.png"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![if gte mso 9]><o:OLEObject Type="Embed" ProgID="PBrush"
   ShapeID="_x0000_s1025" DrawAspect="Content" ObjectID="MBD000884B0">
  </o:OLEObject>
 <![endif]><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:0px;margin-top:0px;width:290px;height:104px'><img
  width=290 height=104 src="htfo00170_Room_Status_hsekeeping_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl66 width=40 style='height:23.25pt;width:30pt'><a
    name="Print_Area"></a></td>
   </tr>
  </table>
  </span></td>
  <td class=xl112 width=38 style='width:29pt'></td>
  <td class=xl112 width=40 style='width:30pt'></td>
  <td class=xl112 width=37 style='width:28pt'></td>
  <td class=xl66 width=37 style='width:28pt'></td>
  <td class=xl112 width=39 style='width:29pt'></td>
  <td class=xl65 width=39 style='width:29pt'></td>
  <td colspan=11 class=xl182 width=442 style='width:334pt'>Daily Guest Room
  Stastus Report</td>
  <td colspan=3 class=xl186 width=126 style='width:96pt'>Last updated:</td>
  <td colspan=5 class=xl187 width=215 style='width:161pt'
  ><%=l_print_date%></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
 </tr>
 <tr height=94 style='mso-height-source:userset;height:70.5pt'>
  <td colspan=3 height=94 class=xl183 width=118 style='height:70.5pt;
  width:89pt' x:str="Second Floor ">Second Floor<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl113 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl113 width=37 style='width:28pt'>&nbsp;</td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=54 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>201</td>
  <td class=xl68 style='border-top:none'>202</td>
  <td class=xl69 style='border-top:none;border-left:none'>203</td>
  <td class=xl70 style='border-top:none;border-left:none'>205</td>
  <td class=xl69 style='border-top:none;border-left:none'>206</td>
  <td class=xl70 style='border-left:none'>207</td>
  <td class=xl69 style='border-left:none'>208</td>
  <td class=xl70 style='border-left:none'>209</td>
  <td class=xl69 style='border-left:none'>210</td>
  <td class=xl69 style='border-left:none'>211</td>
  <td class=xl70 style='border-left:none'>212</td>
  <td class=xl69 style='border-left:none'>215</td>
  <td colspan=2 rowspan=2 class=xl151 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>H/K Dep't</td>
  <td colspan=4 rowspan=2 class=xl169 style='border-right:2.0pt double black;
  border-bottom:.5pt solid black'>Staff Area</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72></td>
  <td colspan=4 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=53 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl74 style='height:12.75pt' ><%=dt.Rows[0][1]%></td>
  <td class=xl75><%=dt.Rows[1][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[2][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[3][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[4][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[5][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[6][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[7][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[8][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[9][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[10][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[11][1]%></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl80 colspan=3 style='mso-ignore:colspan'>To: General Manager</td>
  <td class=xl81></td>
  <td class=xl82></td>
  <td colspan=53 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=83 style='mso-height-source:userset;height:62.25pt'>
 <%
	 string color_sec_2_1="";
		if((dt.Rows[0][3].ToString())=="VD"||(dt.Rows[0][3].ToString())=="VC"||(dt.Rows[0][3].ToString())=="OC"||(dt.Rows[0][3].ToString())=="OD"||(dt.Rows[0][3].ToString())=="OOO")
		{
			if((dt.Rows[0][3].ToString())=="VD")
			  {
				color_sec_2_1="color:#E9D711";
			  }
			 if((dt.Rows[0][3].ToString())=="VC")
			 {
				color_sec_2_1="color:#3366ff";
			  }
			  if((dt.Rows[0][3].ToString())=="OC")
			  {
				color_sec_2_1="color:#0BC02C";
			  }
			 if((dt.Rows[0][3].ToString())=="OD")
			 {
				color_sec_2_1="color:#ff6600";
			  }
			  if((dt.Rows[0][3].ToString())=="OOO")
			  {
				color_sec_2_1="color:#ff0000";
			  }
          %>
  <td height=83 class=xl127 width=40 style='height:62.25pt;border-top:none;
  width:30pt;<%=color_sec_2_1%>'><%=dt.Rows[0][3]%></td>
  <%}%>
  <%
	 string color_sec_2_2="";
		if((dt.Rows[1][3].ToString())=="VD"||(dt.Rows[1][3].ToString())=="VC"||(dt.Rows[1][3].ToString())=="OC"||(dt.Rows[1][3].ToString())=="OD"||(dt.Rows[1][3].ToString())=="OOO")
		{
			if((dt.Rows[1][3].ToString())=="VD")
			  {
				color_sec_2_2="color:#E9D711";
			  }
			 if((dt.Rows[1][3].ToString())=="VC")
			 {
				color_sec_2_2="color:#3366ff";
			  }
			  if((dt.Rows[1][3].ToString())=="OC")
			  {
				color_sec_2_2="color:#0BC02C";
			  }
			 if((dt.Rows[1][3].ToString())=="OD")
			 {
				color_sec_2_2="color:#ff6600";
			  }
			  if((dt.Rows[1][3].ToString())=="OOO")
			  {
				color_sec_2_2="color:#ff0000";
			  }
          %>
  <td class=xl128 width=38 style='border-top:none;width:29pt;<%=color_sec_2_2%>'><%=dt.Rows[1][3]%></td>
  <%}%>
  <%
	 string color_sec_2_3="";
		if((dt.Rows[2][3].ToString())=="VD"||(dt.Rows[2][3].ToString())=="VC"||(dt.Rows[2][3].ToString())=="OC"||(dt.Rows[2][3].ToString())=="OD"||(dt.Rows[2][3].ToString())=="OOO")
		{
			if((dt.Rows[2][3].ToString())=="VD")
			  {
				color_sec_2_3="color:#E9D711";
			  }
			 if((dt.Rows[2][3].ToString())=="VC")
			 {
				color_sec_2_3="color:#3366ff";
			  }
			  if((dt.Rows[2][3].ToString())=="OC")
			  {
				color_sec_2_3="color:#0BC02C";
			  }
			 if((dt.Rows[2][3].ToString())=="OD")
			 {
				color_sec_2_3="color:#ff6600";
			  }
			  if((dt.Rows[2][3].ToString())=="OOO")
			  {
				color_sec_2_3="color:#ff0000";
			  }
          %>
  <td class=xl128 width=40 style='border-top:none;width:30pt;<%=color_sec_2_3%>'><%=dt.Rows[2][3]%></td>
  <%}%>
  <%
	 string color_sec_2_4="";
		if((dt.Rows[3][3].ToString())=="VD"||(dt.Rows[3][3].ToString())=="VC"||(dt.Rows[3][3].ToString())=="OC"||(dt.Rows[3][3].ToString())=="OD"||(dt.Rows[3][3].ToString())=="OOO")
		{
			if((dt.Rows[3][3].ToString())=="VD")
			  {
				color_sec_2_4="color:#E9D711";
			  }
			 if((dt.Rows[3][3].ToString())=="VC")
			 {
				color_sec_2_4="color:#3366ff";
			  }
			  if((dt.Rows[3][3].ToString())=="OC")
			  {
				color_sec_2_4="color:#0BC02C";
			  }
			 if((dt.Rows[3][3].ToString())=="OD")
			 {
				color_sec_2_4="color:#ff6600";
			  }
			  if((dt.Rows[3][3].ToString())=="OOO")
			  {
				color_sec_2_4="color:#ff0000";
			  }
          %>
  <td class=xl129 width=37 style='border-top:none;border-left:none;width:28pt;<%=color_sec_2_4%>'><%=dt.Rows[3][3]%></td>
  <%}%>
  <%
	 string color_sec_2_5="";
		if((dt.Rows[4][3].ToString())=="VD"||(dt.Rows[4][3].ToString())=="VC"||(dt.Rows[4][3].ToString())=="OC"||(dt.Rows[4][3].ToString())=="OD"||(dt.Rows[4][3].ToString())=="OOO")
		{
			if((dt.Rows[4][3].ToString())=="VD")
			  {
				color_sec_2_5="color:#E9D711";
			  }
			 if((dt.Rows[4][3].ToString())=="VC")
			 {
				color_sec_2_5="color:#3366ff";
			  }
			  if((dt.Rows[4][3].ToString())=="OC")
			  {
				color_sec_2_5="color:#0BC02C";
			  }
			 if((dt.Rows[4][3].ToString())=="OD")
			 {
				color_sec_2_5="color:#ff6600";
			  }
			  if((dt.Rows[4][3].ToString())=="OOO")
			  {
				color_sec_2_5="color:#ff0000";
			  }
          %>
  <td class=xl129 width=37 style='border-top:none;border-left:none;width:28pt;<%=color_sec_2_5%>'><%=dt.Rows[4][3]%></td>
   <%}%>
   <%
	 string color_sec_2_6="";
		if((dt.Rows[5][3].ToString())=="VD"||(dt.Rows[5][3].ToString())=="VC"||(dt.Rows[5][3].ToString())=="OC"||(dt.Rows[5][3].ToString())=="OD"||(dt.Rows[5][3].ToString())=="OOO")
		{
			if((dt.Rows[5][3].ToString())=="VD")
			  {
				color_sec_2_6="color:#E9D711";
			  }
			 if((dt.Rows[5][3].ToString())=="VC")
			 {
				color_sec_2_6="color:#3366ff";
			  }
			  if((dt.Rows[5][3].ToString())=="OC")
			  {
				color_sec_2_6="color:#0BC02C";
			  }
			 if((dt.Rows[5][3].ToString())=="OD")
			 {
				color_sec_2_6="color:#ff6600";
			  }
			  if((dt.Rows[5][3].ToString())=="OOO")
			  {
				color_sec_2_6="color:#ff0000";
			  }
          %>
  <td class=xl129 width=39 style='border-top:none;border-left:none;width:29pt;<%=color_sec_2_6%>'><%=dt.Rows[5][3]%></td>
  <%}%>
  <%
	 string color_sec_2_7="";
		if((dt.Rows[6][3].ToString())=="VD"||(dt.Rows[6][3].ToString())=="VC"||(dt.Rows[6][3].ToString())=="OC"||(dt.Rows[6][3].ToString())=="OD"||(dt.Rows[6][3].ToString())=="OOO")
		{
			if((dt.Rows[6][3].ToString())=="VD")
			  {
				color_sec_2_7="color:#E9D711";
			  }
			 if((dt.Rows[6][3].ToString())=="VC")
			 {
				color_sec_2_7="color:#3366ff";
			  }
			  if((dt.Rows[6][3].ToString())=="OC")
			  {
				color_sec_2_7="color:#0BC02C";
			  }
			 if((dt.Rows[6][3].ToString())=="OD")
			 {
				color_sec_2_7="color:#ff6600";
			  }
			  if((dt.Rows[6][3].ToString())=="OOO")
			  {
				color_sec_2_7="color:#ff0000";
			  }
          %>
  <td class=xl129 width=39 style='border-top:none;border-left:none;width:29pt;<%=color_sec_2_7%>'><%=dt.Rows[6][3]%></td>
  <%}%>
  <%
	 string color_sec_2_8="";
		if((dt.Rows[7][3].ToString())=="VD"||(dt.Rows[7][3].ToString())=="VC"||(dt.Rows[7][3].ToString())=="OC"||(dt.Rows[7][3].ToString())=="OD"||(dt.Rows[7][3].ToString())=="OOO")
		{
			if((dt.Rows[7][3].ToString())=="VD")
			  {
				color_sec_2_8="color:#E9D711";
			  }
			 if((dt.Rows[7][3].ToString())=="VC")
			 {
				color_sec_2_8="color:#3366ff";
			  }
			  if((dt.Rows[7][3].ToString())=="OC")
			  {
				color_sec_2_8="color:#0BC02C";
			  }
			 if((dt.Rows[7][3].ToString())=="OD")
			 {
				color_sec_2_8="color:#ff6600";
			  }
			  if((dt.Rows[7][3].ToString())=="OOO")
			  {
				color_sec_2_8="color:#ff0000";
			  }
          %>
  <td class=xl129 width=37 style='border-top:none;border-left:none;width:28pt;<%=color_sec_2_8%>'><%=dt.Rows[7][3]%></td>
  <%}%>
  <%
	 string color_sec_2_9="";
		if((dt.Rows[8][3].ToString())=="VD"||(dt.Rows[8][3].ToString())=="VC"||(dt.Rows[8][3].ToString())=="OC"||(dt.Rows[8][3].ToString())=="OD"||(dt.Rows[8][3].ToString())=="OOO")
		{
			if((dt.Rows[8][3].ToString())=="VD")
			  {
				color_sec_2_9="color:#E9D711";
			  }
			 if((dt.Rows[8][3].ToString())=="VC")
			 {
				color_sec_2_9="color:#3366ff";
			  }
			  if((dt.Rows[8][3].ToString())=="OC")
			  {
				color_sec_2_9="color:#0BC02C";
			  }
			 if((dt.Rows[8][3].ToString())=="OD")
			 {
				color_sec_2_9="color:#ff6600";
			  }
			  if((dt.Rows[8][3].ToString())=="OOO")
			  {
				color_sec_2_9="color:#ff0000";
			  }
          %>
  <td class=xl130 style='border-top:none;border-left:none;<%=color_sec_2_9%>'><%=dt.Rows[8][3]%></td>
  <%}%>
  <%
	 string color_sec_2_10="";
		if((dt.Rows[9][3].ToString())=="VD"||(dt.Rows[9][3].ToString())=="VC"||(dt.Rows[9][3].ToString())=="OC"||(dt.Rows[9][3].ToString())=="OD"||(dt.Rows[9][3].ToString())=="OOO")
		{
			if((dt.Rows[9][3].ToString())=="VD")
			  {
				color_sec_2_10="color:#E9D711";
			  }
			 if((dt.Rows[9][3].ToString())=="VC")
			 {
				color_sec_2_10="color:#3366ff";
			  }
			  if((dt.Rows[9][3].ToString())=="OC")
			  {
				color_sec_2_10="color:#0BC02C";
			  }
			 if((dt.Rows[9][3].ToString())=="OD")
			 {
				color_sec_2_10="color:#ff6600";
			  }
			  if((dt.Rows[9][3].ToString())=="OOO")
			  {
				color_sec_2_10="color:#ff0000";
			  }
          %>
  <td class=xl130 style='border-top:none;border-left:none;<%=color_sec_2_10%>'><%=dt.Rows[9][3]%></td>
   <%}%>
   <%
	 string color_sec_2_11="";
		if((dt.Rows[10][3].ToString())=="VD"||(dt.Rows[10][3].ToString())=="VC"||(dt.Rows[10][3].ToString())=="OC"||(dt.Rows[10][3].ToString())=="OD"||(dt.Rows[10][3].ToString())=="OOO")
		{
			if((dt.Rows[10][3].ToString())=="VD")
			  {
				color_sec_2_11="color:#E9D711";
			  }
			 if((dt.Rows[10][3].ToString())=="VC")
			 {
				color_sec_2_11="color:#3366ff";
			  }
			  if((dt.Rows[10][3].ToString())=="OC")
			  {
				color_sec_2_11="color:#0BC02C";
			  }
			 if((dt.Rows[10][3].ToString())=="OD")
			 {
				color_sec_2_11="color:#ff6600";
			  }
			  if((dt.Rows[10][3].ToString())=="OOO")
			  {
				color_sec_2_11="color:#ff0000";
			  }
          %>
  <td class=xl131 style='border-top:none;border-left:none;<%=color_sec_2_11%>'><%=dt.Rows[10][3]%></td>
  <%}%>
  <%
	 string color_sec_2_12="";
		if((dt.Rows[11][3].ToString())=="VD"||(dt.Rows[11][3].ToString())=="VC"||(dt.Rows[11][3].ToString())=="OC"||(dt.Rows[11][3].ToString())=="OD"||(dt.Rows[11][3].ToString())=="OOO")
		{
			if((dt.Rows[11][3].ToString())=="VD")
			  {
				color_sec_2_12="color:#E9D711";
			  }
			 if((dt.Rows[11][3].ToString())=="VC")
			 {
				color_sec_2_12="color:#3366ff";
			  }
			  if((dt.Rows[11][3].ToString())=="OC")
			  {
				color_sec_2_12="color:#0BC02C";
			  }
			 if((dt.Rows[11][3].ToString())=="OD")
			 {
				color_sec_2_12="color:#ff6600";
			  }
			  if((dt.Rows[11][3].ToString())=="OOO")
			  {
				color_sec_2_12="color:#ff0000";
			  }
          %>
  <td class=xl130 style='border-top:none;border-left:none;<%=color_sec_2_12%>'><%=dt.Rows[11][3]%></td>
  <%}%>
  <td class=xl114 style='border-top:none;border-left:none'>Office</td>
  <td class=xl115 style='border-top:none;border-left:none'>Linen Room</td>
  <td class=xl114 style='border-top:none;border-left:none'>WC Staffs</td>
  <td class=xl116 style='border-top:none;border-left:none'>Showers</td>
  <td class=xl117 style='border-top:none;border-left:none'>Locker</td>
  <td class=xl118 style='border-top:none;border-left:none'>Resting</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl119></td>
  <td class=xl83></td>
  <td class=xl120></td>
  <td class=xl84></td>
  <td colspan=54 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=6 class=xl71 style='height:13.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=12 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl191>Suite Delux (SUX):</td>
  <td class=xl86 style='border-left:none' x:num><%=dt2.Rows[0][0]%></td>
  <td colspan=3 class=xl196 style='border-left:none'>( 80m2)</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl180 style='height:15.75pt'>Third Floor</td>
  <td class=xl87>&nbsp;</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=11 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td colspan=3 class=xl190 x:str="Suite (SUS): ">Suite (SUS):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><%=dt2.Rows[0][1]%></td>
  <td colspan=3 class=xl196 style='border-left:none'>( 60m2)</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt;border-top:none'>301</td>
  <td class=xl70 style='border-top:none;border-left:none'>302</td>
  <td class=xl69 style='border-top:none;border-left:none'>303</td>
  <td class=xl70 style='border-left:none'>305</td>
  <td class=xl69 style='border-left:none'>306</td>
  <td class=xl70 style='border-left:none'>307</td>
  <td class=xl69 style='border-left:none'>308</td>
  <td class=xl70 style='border-left:none'>309</td>
  <td class=xl69 style='border-left:none'>310</td>
  <td class=xl69 style='border-left:none'>311</td>
  <td class=xl70 style='border-left:none'>312</td>
  <td class=xl69 style='border-left:none'>315</td>
  <td class=xl70 style='border-left:none'>316</td>
  <td class=xl69 style='border-left:none'>317</td>
  <td class=xl70 style='border-left:none'>318</td>
  <td class=xl69 style='border-left:none'>319</td>
  <td class=xl69 style='border-left:none'>320</td>
  <td class=xl90 style='border-left:none'>321</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=3 class=xl192 x:str="Studio-Queen (STQ): ">Studio-Queen (STQ):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[0][2]%></td>
  <td colspan=3 class=xl196 style='border-left:none'>( 40m2)</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'><%=dt.Rows[12][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[13][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[14][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[15][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[16][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[17][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[18][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[19][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[20][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[21][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[22][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[23][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[24][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[25][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[26][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[27][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[28][1]%></td>
  <td class=xl92 style='border-left:none'><%=dt.Rows[29][1]%></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=3 class=xl193 x:str="Studio-Twin (STT): ">Studio-Twin (STT):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl121 style='border-top:none;border-left:none' x:num><%=dt2.Rows[0][3]%></td>
  <td colspan=3 class=xl196 style='border-left:none'>( 40m2)</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=77 style='mso-height-source:userset;height:57.75pt'>
 <%
	 string color_sec_3_13="";
		if((dt.Rows[12][3].ToString())=="VD"||(dt.Rows[12][3].ToString())=="VC"||(dt.Rows[12][3].ToString())=="OC"||(dt.Rows[12][3].ToString())=="OD"||(dt.Rows[12][3].ToString())=="OOO")
		{
			if((dt.Rows[12][3].ToString())=="VD")
			  {
				color_sec_3_13="color:#E9D711";
			  }
			 if((dt.Rows[12][3].ToString())=="VC")
			 {
				color_sec_3_13="color:#3366ff";
			  }
			  if((dt.Rows[12][3].ToString())=="OC")
			  {
				color_sec_3_13="color:#0BC02C";
			  }
			 if((dt.Rows[12][3].ToString())=="OD")
			 {
				color_sec_3_13="color:#ff6600";
			  }
			  if((dt.Rows[12][3].ToString())=="OOO")
			  {
				color_sec_3_13="color:#ff0000";
			  }
          %>
  <td height=77 class=xl139 style='height:57.75pt;<%=color_sec_3_13%>'><%=dt.Rows[12][3]%></td>
  <%}%>
  <%
	 string color_sec_2_14="";
		if((dt.Rows[13][3].ToString())=="VD"||(dt.Rows[13][3].ToString())=="VC"||(dt.Rows[13][3].ToString())=="OC"||(dt.Rows[13][3].ToString())=="OD"||(dt.Rows[13][3].ToString())=="OOO")
		{
			if((dt.Rows[13][3].ToString())=="VD")
			  {
				color_sec_2_14="color:#E9D711";
			  }
			 if((dt.Rows[13][3].ToString())=="VC")
			 {
				color_sec_2_14="color:#3366ff";
			  }
			  if((dt.Rows[13][3].ToString())=="OC")
			  {
				color_sec_2_14="color:#0BC02C";
			  }
			 if((dt.Rows[13][3].ToString())=="OD")
			 {
				color_sec_2_14="color:#ff6600";
			  }
			  if((dt.Rows[13][3].ToString())=="OOO")
			  {
				color_sec_2_14="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_14%>'><%=dt.Rows[13][3]%></td>
  <%}%>
  <%
	 string color_sec_2_15="";
		if((dt.Rows[14][3].ToString())=="VD"||(dt.Rows[14][3].ToString())=="VC"||(dt.Rows[14][3].ToString())=="OC"||(dt.Rows[14][3].ToString())=="OD"||(dt.Rows[14][3].ToString())=="OOO")
		{
			if((dt.Rows[14][3].ToString())=="VD")
			  {
				color_sec_2_15="color:#E9D711";
			  }
			 if((dt.Rows[14][3].ToString())=="VC")
			 {
				color_sec_2_15="color:#3366ff";
			  }
			  if((dt.Rows[14][3].ToString())=="OC")
			  {
				color_sec_2_15="color:#0BC02C";
			  }
			 if((dt.Rows[14][3].ToString())=="OD")
			 {
				color_sec_2_15="color:#ff6600";
			  }
			  if((dt.Rows[14][3].ToString())=="OOO")
			  {
				color_sec_2_15="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_15%>'><%=dt.Rows[14][3]%></td>
  <%}%>
  <%
	 string color_sec_2_16="";
		if((dt.Rows[15][3].ToString())=="VD"||(dt.Rows[15][3].ToString())=="VC"||(dt.Rows[15][3].ToString())=="OC"||(dt.Rows[15][3].ToString())=="OD"||(dt.Rows[15][3].ToString())=="OOO")
		{
			if((dt.Rows[15][3].ToString())=="VD")
			  {
				color_sec_2_16="color:#E9D711";
			  }
			 if((dt.Rows[15][3].ToString())=="VC")
			 {
				color_sec_2_16="color:#3366ff";
			  }
			  if((dt.Rows[15][3].ToString())=="OC")
			  {
				color_sec_2_16="color:#0BC02C";
			  }
			 if((dt.Rows[15][3].ToString())=="OD")
			 {
				color_sec_2_16="color:#ff6600";
			  }
			  if((dt.Rows[15][3].ToString())=="OOO")
			  {
				color_sec_2_16="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_16%>'><%=dt.Rows[15][3]%></td>
  <%}%>
  <%
	 string color_sec_2_17="";
		if((dt.Rows[16][3].ToString())=="VD"||(dt.Rows[16][3].ToString())=="VC"||(dt.Rows[16][3].ToString())=="OC"||(dt.Rows[16][3].ToString())=="OD"||(dt.Rows[16][3].ToString())=="OOO")
		{
			if((dt.Rows[16][3].ToString())=="VD")
			  {
				color_sec_2_17="color:#E9D711";
			  }
			 if((dt.Rows[16][3].ToString())=="VC")
			 {
				color_sec_2_17="color:#3366ff";
			  }
			  if((dt.Rows[16][3].ToString())=="OC")
			  {
				color_sec_2_17="color:#0BC02C";
			  }
			 if((dt.Rows[16][3].ToString())=="OD")
			 {
				color_sec_2_17="color:#ff6600";
			  }
			  if((dt.Rows[16][3].ToString())=="OOO")
			  {
				color_sec_2_17="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_17%>'><%=dt.Rows[16][3]%></td>
  <%}%>
  <%
	 string color_sec_2_18="";
		if((dt.Rows[17][3].ToString())=="VD"||(dt.Rows[17][3].ToString())=="VC"||(dt.Rows[17][3].ToString())=="OC"||(dt.Rows[17][3].ToString())=="OD"||(dt.Rows[17][3].ToString())=="OOO")
		{
			if((dt.Rows[17][3].ToString())=="VD")
			  {
				color_sec_2_18="color:#E9D711";
			  }
			 if((dt.Rows[17][3].ToString())=="VC")
			 {
				color_sec_2_18="color:#3366ff";
			  }
			  if((dt.Rows[17][3].ToString())=="OC")
			  {
				color_sec_2_18="color:#0BC02C";
			  }
			 if((dt.Rows[17][3].ToString())=="OD")
			 {
				color_sec_2_18="color:#ff6600";
			  }
			  if((dt.Rows[17][3].ToString())=="OOO")
			  {
				color_sec_2_18="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_18%>'><%=dt.Rows[17][3]%></td>
  <%}%>
  <%
	 string color_sec_2_19="";
		if((dt.Rows[18][3].ToString())=="VD"||(dt.Rows[18][3].ToString())=="VC"||(dt.Rows[18][3].ToString())=="OC"||(dt.Rows[18][3].ToString())=="OD"||(dt.Rows[18][3].ToString())=="OOO")
		{
			if((dt.Rows[18][3].ToString())=="VD")
			  {
				color_sec_2_19="color:#E9D711";
			  }
			 if((dt.Rows[18][3].ToString())=="VC")
			 {
				color_sec_2_19="color:#3366ff";
			  }
			  if((dt.Rows[18][3].ToString())=="OC")
			  {
				color_sec_2_19="color:#0BC02C";
			  }
			 if((dt.Rows[18][3].ToString())=="OD")
			 {
				color_sec_2_19="color:#ff6600";
			  }
			  if((dt.Rows[18][3].ToString())=="OOO")
			  {
				color_sec_2_19="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_19%>'><%=dt.Rows[18][3]%></td>
  <%}%>
  <%
	 string color_sec_2_20="";
		if((dt.Rows[19][3].ToString())=="VD"||(dt.Rows[19][3].ToString())=="VC"||(dt.Rows[19][3].ToString())=="OC"||(dt.Rows[19][3].ToString())=="OD"||(dt.Rows[19][3].ToString())=="OOO")
		{
			if((dt.Rows[19][3].ToString())=="VD")
			  {
				color_sec_2_20="color:#E9D711";
			  }
			 if((dt.Rows[19][3].ToString())=="VC")
			 {
				color_sec_2_20="color:#3366ff";
			  }
			  if((dt.Rows[19][3].ToString())=="OC")
			  {
				color_sec_2_20="color:#0BC02C";
			  }
			 if((dt.Rows[19][3].ToString())=="OD")
			 {
				color_sec_2_20="color:#ff6600";
			  }
			  if((dt.Rows[19][3].ToString())=="OOO")
			  {
				color_sec_2_20="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_20%>'><%=dt.Rows[19][3]%></td>
  <%}%>
  <%
	 string color_sec_2_21="";
		if((dt.Rows[20][3].ToString())=="VD"||(dt.Rows[20][3].ToString())=="VC"||(dt.Rows[20][3].ToString())=="OC"||(dt.Rows[20][3].ToString())=="OD"||(dt.Rows[20][3].ToString())=="OOO")
		{
			if((dt.Rows[20][3].ToString())=="VD")
			  {
				color_sec_2_21="color:#E9D711";
			  }
			 if((dt.Rows[20][3].ToString())=="VC")
			 {
				color_sec_2_21="color:#3366ff";
			  }
			  if((dt.Rows[20][3].ToString())=="OC")
			  {
				color_sec_2_21="color:#0BC02C";
			  }
			 if((dt.Rows[20][3].ToString())=="OD")
			 {
				color_sec_2_21="color:#ff6600";
			  }
			  if((dt.Rows[20][3].ToString())=="OOO")
			  {
				color_sec_2_21="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_21%>'><%=dt.Rows[20][3]%></td>
  <%}%>
  <%
	 string color_sec_2_22="";
		if((dt.Rows[21][3].ToString())=="VD"||(dt.Rows[21][3].ToString())=="VC"||(dt.Rows[21][3].ToString())=="OC"||(dt.Rows[21][3].ToString())=="OD"||(dt.Rows[21][3].ToString())=="OOO")
		{
			if((dt.Rows[21][3].ToString())=="VD")
			  {
				color_sec_2_22="color:#E9D711";
			  }
			 if((dt.Rows[21][3].ToString())=="VC")
			 {
				color_sec_2_22="color:#3366ff";
			  }
			  if((dt.Rows[21][3].ToString())=="OC")
			  {
				color_sec_2_22="color:#0BC02C";
			  }
			 if((dt.Rows[21][3].ToString())=="OD")
			 {
				color_sec_2_22="color:#ff6600";
			  }
			  if((dt.Rows[21][3].ToString())=="OOO")
			  {
				color_sec_2_22="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_22%>'><%=dt.Rows[21][3]%></td>
  <%}%>
  <%
	 string color_sec_2_23="";
		if((dt.Rows[22][3].ToString())=="VD"||(dt.Rows[22][3].ToString())=="VC"||(dt.Rows[22][3].ToString())=="OC"||(dt.Rows[22][3].ToString())=="OD"||(dt.Rows[22][3].ToString())=="OOO")
		{
			if((dt.Rows[22][3].ToString())=="VD")
			  {
				color_sec_2_23="color:#E9D711";
			  }
			 if((dt.Rows[22][3].ToString())=="VC")
			 {
				color_sec_2_23="color:#3366ff";
			  }
			  if((dt.Rows[22][3].ToString())=="OC")
			  {
				color_sec_2_23="color:#0BC02C";
			  }
			 if((dt.Rows[22][3].ToString())=="OD")
			 {
				color_sec_2_23="color:#ff6600";
			  }
			  if((dt.Rows[22][3].ToString())=="OOO")
			  {
				color_sec_2_23="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_23%>'><%=dt.Rows[22][3]%></td>
  <%}%>
  <%
	 string color_sec_2_24="";
		if((dt.Rows[23][3].ToString())=="VD"||(dt.Rows[23][3].ToString())=="VC"||(dt.Rows[23][3].ToString())=="OC"||(dt.Rows[23][3].ToString())=="OD"||(dt.Rows[23][3].ToString())=="OOO")
		{
			if((dt.Rows[23][3].ToString())=="VD")
			  {
				color_sec_2_24="color:#E9D711";
			  }
			 if((dt.Rows[23][3].ToString())=="VC")
			 {
				color_sec_2_24="color:#3366ff";
			  }
			  if((dt.Rows[23][3].ToString())=="OC")
			  {
				color_sec_2_24="color:#0BC02C";
			  }
			 if((dt.Rows[23][3].ToString())=="OD")
			 {
				color_sec_2_24="color:#ff6600";
			  }
			  if((dt.Rows[23][3].ToString())=="OOO")
			  {
				color_sec_2_24="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_24%>'><%=dt.Rows[23][3]%></td>
  <%}%>
  <%
	 string color_sec_2_25="";
		if((dt.Rows[24][3].ToString())=="VD"||(dt.Rows[24][3].ToString())=="VC"||(dt.Rows[24][3].ToString())=="OC"||(dt.Rows[24][3].ToString())=="OD"||(dt.Rows[24][3].ToString())=="OOO")
		{
			if((dt.Rows[24][3].ToString())=="VD")
			  {
				color_sec_2_25="color:#E9D711";
			  }
			 if((dt.Rows[24][3].ToString())=="VC")
			 {
				color_sec_2_25="color:#3366ff";
			  }
			  if((dt.Rows[24][3].ToString())=="OC")
			  {
				color_sec_2_25="color:#0BC02C";
			  }
			 if((dt.Rows[24][3].ToString())=="OD")
			 {
				color_sec_2_25="color:#ff6600";
			  }
			  if((dt.Rows[24][3].ToString())=="OOO")
			  {
				color_sec_2_25="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_25%>'><%=dt.Rows[24][3]%></td>
  <%}%>
  <%
	 string color_sec_2_26="";
		if((dt.Rows[25][3].ToString())=="VD"||(dt.Rows[25][3].ToString())=="VC"||(dt.Rows[25][3].ToString())=="OC"||(dt.Rows[25][3].ToString())=="OD"||(dt.Rows[25][3].ToString())=="OOO")
		{
			if((dt.Rows[25][3].ToString())=="VD")
			  {
				color_sec_2_26="color:#E9D711";
			  }
			 if((dt.Rows[25][3].ToString())=="VC")
			 {
				color_sec_2_26="color:#3366ff";
			  }
			  if((dt.Rows[25][3].ToString())=="OC")
			  {
				color_sec_2_26="color:#0BC02C";
			  }
			 if((dt.Rows[25][3].ToString())=="OD")
			 {
				color_sec_2_26="color:#ff6600";
			  }
			  if((dt.Rows[25][3].ToString())=="OOO")
			  {
				color_sec_2_26="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_26%>'><%=dt.Rows[25][3]%></td>
  <%}%>
  <%
	 string color_sec_2_27="";
		if((dt.Rows[26][3].ToString())=="VD"||(dt.Rows[26][3].ToString())=="VC"||(dt.Rows[26][3].ToString())=="OC"||(dt.Rows[26][3].ToString())=="OD"||(dt.Rows[26][3].ToString())=="OOO")
		{
			if((dt.Rows[26][3].ToString())=="VD")
			  {
				color_sec_2_27="color:#E9D711";
			  }
			 if((dt.Rows[26][3].ToString())=="VC")
			 {
				color_sec_2_27="color:#3366ff";
			  }
			  if((dt.Rows[26][3].ToString())=="OC")
			  {
				color_sec_2_27="color:#0BC02C";
			  }
			 if((dt.Rows[26][3].ToString())=="OD")
			 {
				color_sec_2_27="color:#ff6600";
			  }
			  if((dt.Rows[26][3].ToString())=="OOO")
			  {
				color_sec_2_27="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_27%>'><%=dt.Rows[26][3]%></td>
  <%}%>
  <%
	 string color_sec_2_28="";
		if((dt.Rows[27][3].ToString())=="VD"||(dt.Rows[27][3].ToString())=="VC"||(dt.Rows[27][3].ToString())=="OC"||(dt.Rows[27][3].ToString())=="OD"||(dt.Rows[27][3].ToString())=="OOO")
		{
			if((dt.Rows[27][3].ToString())=="VD")
			  {
				color_sec_2_28="color:#E9D711";
			  }
			 if((dt.Rows[27][3].ToString())=="VC")
			 {
				color_sec_2_28="color:#3366ff";
			  }
			  if((dt.Rows[27][3].ToString())=="OC")
			  {
				color_sec_2_28="color:#0BC02C";
			  }
			 if((dt.Rows[27][3].ToString())=="OD")
			 {
				color_sec_2_28="color:#ff6600";
			  }
			  if((dt.Rows[27][3].ToString())=="OOO")
			  {
				color_sec_2_28="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_28%>'><%=dt.Rows[27][3]%></td>
  <%}%>
  <%
	 string color_sec_2_29="";
		if((dt.Rows[28][3].ToString())=="VD"||(dt.Rows[28][3].ToString())=="VC"||(dt.Rows[28][3].ToString())=="OC"||(dt.Rows[28][3].ToString())=="OD"||(dt.Rows[28][3].ToString())=="OOO")
		{
			if((dt.Rows[28][3].ToString())=="VD")
			  {
				color_sec_2_29="color:#E9D711";
			  }
			 if((dt.Rows[28][3].ToString())=="VC")
			 {
				color_sec_2_29="color:#3366ff";
			  }
			  if((dt.Rows[28][3].ToString())=="OC")
			  {
				color_sec_2_29="color:#0BC02C";
			  }
			 if((dt.Rows[28][3].ToString())=="OD")
			 {
				color_sec_2_29="color:#ff6600";
			  }
			  if((dt.Rows[28][3].ToString())=="OOO")
			  {
				color_sec_2_29="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_29%>'><%=dt.Rows[28][3]%></td>
  <%}%>
  <%
	 string color_sec_2_30="";
		if((dt.Rows[29][3].ToString())=="VD"||(dt.Rows[29][3].ToString())=="VC"||(dt.Rows[29][3].ToString())=="OC"||(dt.Rows[29][3].ToString())=="OD"||(dt.Rows[29][3].ToString())=="OOO")
		{
			if((dt.Rows[29][3].ToString())=="VD")
			  {
				color_sec_2_30="color:#E9D711";
			  }
			 if((dt.Rows[29][3].ToString())=="VC")
			 {
				color_sec_2_30="color:#3366ff";
			  }
			  if((dt.Rows[29][3].ToString())=="OC")
			  {
				color_sec_2_30="color:#0BC02C";
			  }
			 if((dt.Rows[29][3].ToString())=="OD")
			 {
				color_sec_2_30="color:#ff6600";
			  }
			  if((dt.Rows[29][3].ToString())=="OOO")
			  {
				color_sec_2_30="color:#ff0000";
			  }
          %>
  <td class=xl142 style='border-top:none;border-left:none;<%=color_sec_2_30%>'><%=dt.Rows[29][3]%></td>
  <%}%>
  <td class=xl122>&nbsp;</td>
  <td colspan=3 class=xl199 style='border-right:.5pt solid black'>Total:</td>
  <td class=xl123 style='border-top:none;border-left:none' x:num
  x:num><%=dt2.Rows[0][4]%></td>
  <td colspan=3 class=xl197 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 class=xl71 style='height:14.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=7 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl71><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl93 style='border-top:none'>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 class=xl197 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl86 style='border-top:none;border-left:none'>SUX</td>
  <td class=xl133 style='border-top:none;border-left:none'>SUS</td>
  <td class=xl150 style='border-top:none;border-left:none'>STT</td>
  <td class=xl134 style='border-top:none;border-left:none'>STQ</td>
  <td class=xl123 style='border-top:none;border-left:none'>Total</td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=3 height=18 class=xl181 style='height:13.5pt'>Fourth Floor</td>
  <td class=xl94>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td colspan=7 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl188>O.O.O</td>
  <td class=xl132 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt;border-top:none'>401</td>
  <td class=xl97 style='border-top:none'>402</td>
  <td class=xl70 style='border-top:none;border-left:none'>403</td>
  <td class=xl97>405</td>
  <td class=xl70 style='border-left:none'>406</td>
  <td class=xl69 style='border-left:none'>407</td>
  <td class=xl70 style='border-left:none'>408</td>
  <td class=xl69 style='border-left:none'>409</td>
  <td class=xl70 style='border-left:none'>410</td>
  <td class=xl68>411</td>
  <td class=xl69 style='border-left:none'>412</td>
  <td class=xl70 style='border-top:none;border-left:none'>415</td>
  <td class=xl97>416</td>
  <td class=xl70 style='border-left:none'>417</td>
  <td colspan=2 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>418</td>
  <td colspan=2 class=xl184 style='border-right:2.0pt double black;border-left:
  none'>419</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 class=xl189>O.C</td>
  <td class=xl135 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl99 style='height:14.25pt'><%=dt.Rows[30][1]%></td>
  <td class=xl75><%=dt.Rows[31][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[32][1]%></td>
  <td class=xl75><%=dt.Rows[33][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[34][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[35][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[36][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[37][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[38][1]%></td>
  <td class=xl100><%=dt.Rows[39][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[40][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[41][1]%></td>
  <td class=xl75><%=dt.Rows[42][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[43][1]%></td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[44][1]%></td>
  <td colspan=2 class=xl101 style='border-right:2.0pt double black;border-left:
  none'><%=dt.Rows[45][1]%></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 class=xl190>O.D</td>
  <td class=xl136 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
 <%
	 string color_sec_4_31="";
		if((dt.Rows[30][3].ToString())=="VD"||(dt.Rows[30][3].ToString())=="VC"||(dt.Rows[30][3].ToString())=="OC"||(dt.Rows[30][3].ToString())=="OD"||(dt.Rows[30][3].ToString())=="OOO")
		{
			if((dt.Rows[30][3].ToString())=="VD")
			  {
				color_sec_4_31="color:#E9D711";
			  }
			 if((dt.Rows[30][3].ToString())=="VC")
			 {
				color_sec_4_31="color:#3366ff";
			  }
			  if((dt.Rows[30][3].ToString())=="OC")
			  {
				color_sec_4_31="color:#0BC02C";
			  }
			 if((dt.Rows[30][3].ToString())=="OD")
			 {
				color_sec_4_31="color:#ff6600";
			  }
			  if((dt.Rows[30][3].ToString())=="OOO")
			  {
				color_sec_4_31="color:#ff0000";
			  }
          %>
  <td height=65 class=xl143 style='height:48.75pt;border-top:none;<%=color_sec_4_31%>'><%=dt.Rows[30][3]%></td>
  <%}%>
  <%
	 string color_sec_2_32="";
		if((dt.Rows[31][3].ToString())=="VD"||(dt.Rows[31][3].ToString())=="VC"||(dt.Rows[31][3].ToString())=="OC"||(dt.Rows[31][3].ToString())=="OD"||(dt.Rows[31][3].ToString())=="OOO")
		{
			if((dt.Rows[31][3].ToString())=="VD")
			  {
				color_sec_2_32="color:#E9D711";
			  }
			 if((dt.Rows[31][3].ToString())=="VC")
			 {
				color_sec_2_32="color:#3366ff";
			  }
			  if((dt.Rows[31][3].ToString())=="OC")
			  {
				color_sec_2_32="color:#0BC02C";
			  }
			 if((dt.Rows[31][3].ToString())=="OD")
			 {
				color_sec_2_32="color:#ff6600";
			  }
			  if((dt.Rows[31][3].ToString())=="OOO")
			  {
				color_sec_2_32="color:#ff0000";
			  }
          %>
  <td class=xl144 style='border-top:none;<%=color_sec_2_32%>'><%=dt.Rows[31][3]%></td>
  <%}%>
  <%
	 string color_sec_2_33="";
		if((dt.Rows[32][3].ToString())=="VD"||(dt.Rows[32][3].ToString())=="VC"||(dt.Rows[32][3].ToString())=="OC"||(dt.Rows[32][3].ToString())=="OD"||(dt.Rows[32][3].ToString())=="OOO")
		{
			if((dt.Rows[32][3].ToString())=="VD")
			  {
				color_sec_2_33="color:#E9D711";
			  }
			 if((dt.Rows[32][3].ToString())=="VC")
			 {
				color_sec_2_33="color:#3366ff";
			  }
			  if((dt.Rows[32][3].ToString())=="OC")
			  {
				color_sec_2_33="color:#0BC02C";
			  }
			 if((dt.Rows[32][3].ToString())=="OD")
			 {
				color_sec_2_33="color:#ff6600";
			  }
			  if((dt.Rows[32][3].ToString())=="OOO")
			  {
				color_sec_2_33="color:#ff0000";
			  }
          %>
  <td class=xl145 style='border-top:none;border-left:none;<%=color_sec_2_33%>'><%=dt.Rows[32][3]%></td>
  <%}%>
  <%
	 string color_sec_2_34="";
		if((dt.Rows[33][3].ToString())=="VD"||(dt.Rows[33][3].ToString())=="VC"||(dt.Rows[33][3].ToString())=="OC"||(dt.Rows[33][3].ToString())=="OD"||(dt.Rows[33][3].ToString())=="OOO")
		{
			if((dt.Rows[33][3].ToString())=="VD")
			  {
				color_sec_2_34="color:#E9D711";
			  }
			 if((dt.Rows[33][3].ToString())=="VC")
			 {
				color_sec_2_34="color:#3366ff";
			  }
			  if((dt.Rows[33][3].ToString())=="OC")
			  {
				color_sec_2_34="color:#0BC02C";
			  }
			 if((dt.Rows[33][3].ToString())=="OD")
			 {
				color_sec_2_34="color:#ff6600";
			  }
			  if((dt.Rows[33][3].ToString())=="OOO")
			  {
				color_sec_2_34="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_34%>'><%=dt.Rows[33][3]%></td>
  <%}%>
  <%
	 string color_sec_2_35="";
		if((dt.Rows[34][3].ToString())=="VD"||(dt.Rows[34][3].ToString())=="VC"||(dt.Rows[34][3].ToString())=="OC"||(dt.Rows[34][3].ToString())=="OD"||(dt.Rows[34][3].ToString())=="OOO")
		{
			if((dt.Rows[34][3].ToString())=="VD")
			  {
				color_sec_2_35="color:#E9D711";
			  }
			 if((dt.Rows[34][3].ToString())=="VC")
			 {
				color_sec_2_35="color:#3366ff";
			  }
			  if((dt.Rows[34][3].ToString())=="OC")
			  {
				color_sec_2_35="color:#0BC02C";
			  }
			 if((dt.Rows[34][3].ToString())=="OD")
			 {
				color_sec_2_35="color:#ff6600";
			  }
			  if((dt.Rows[34][3].ToString())=="OOO")
			  {
				color_sec_2_35="color:#ff0000";
			  }
          %>
  <td class=xl145 style='border-top:none;border-left:none;<%=color_sec_2_35%>'><%=dt.Rows[34][3]%></td>
  <%}%>
  <%
	 string color_sec_2_36="";
		if((dt.Rows[35][3].ToString())=="VD"||(dt.Rows[35][3].ToString())=="VC"||(dt.Rows[35][3].ToString())=="OC"||(dt.Rows[35][3].ToString())=="OD"||(dt.Rows[35][3].ToString())=="OOO")
		{
			if((dt.Rows[35][3].ToString())=="VD")
			  {
				color_sec_2_36="color:#E9D711";
			  }
			 if((dt.Rows[35][3].ToString())=="VC")
			 {
				color_sec_2_36="color:#3366ff";
			  }
			  if((dt.Rows[35][3].ToString())=="OC")
			  {
				color_sec_2_36="color:#0BC02C";
			  }
			 if((dt.Rows[35][3].ToString())=="OD")
			 {
				color_sec_2_36="color:#ff6600";
			  }
			  if((dt.Rows[35][3].ToString())=="OOO")
			  {
				color_sec_2_36="color:#ff0000";
			  }
          %>
  <td class=xl145 style='border-top:none;border-left:none;<%=color_sec_2_36%>'><%=dt.Rows[35][3]%></td>
  <%}%>
  <%
	 string color_sec_2_37="";
		if((dt.Rows[36][3].ToString())=="VD"||(dt.Rows[36][3].ToString())=="VC"||(dt.Rows[36][3].ToString())=="OC"||(dt.Rows[36][3].ToString())=="OD"||(dt.Rows[36][3].ToString())=="OOO")
		{
			if((dt.Rows[36][3].ToString())=="VD")
			  {
				color_sec_2_37="color:#E9D711";
			  }
			 if((dt.Rows[36][3].ToString())=="VC")
			 {
				color_sec_2_37="color:#3366ff";
			  }
			  if((dt.Rows[36][3].ToString())=="OC")
			  {
				color_sec_2_37="color:#0BC02C";
			  }
			 if((dt.Rows[36][3].ToString())=="OD")
			 {
				color_sec_2_37="color:#ff6600";
			  }
			  if((dt.Rows[36][3].ToString())=="OOO")
			  {
				color_sec_2_37="color:#ff0000";
			  }
          %>
  <td class=xl145 style='border-top:none;border-left:none;<%=color_sec_2_37%>'><%=dt.Rows[36][3]%></td>
  <%}%>
  <%
	 string color_sec_2_38="";
		if((dt.Rows[37][3].ToString())=="VD"||(dt.Rows[37][3].ToString())=="VC"||(dt.Rows[37][3].ToString())=="OC"||(dt.Rows[37][3].ToString())=="OD"||(dt.Rows[37][3].ToString())=="OOO")
		{
			if((dt.Rows[37][3].ToString())=="VD")
			  {
				color_sec_2_38="color:#E9D711";
			  }
			 if((dt.Rows[37][3].ToString())=="VC")
			 {
				color_sec_2_38="color:#3366ff";
			  }
			  if((dt.Rows[37][3].ToString())=="OC")
			  {
				color_sec_2_38="color:#0BC02C";
			  }
			 if((dt.Rows[37][3].ToString())=="OD")
			 {
				color_sec_2_38="color:#ff6600";
			  }
			  if((dt.Rows[37][3].ToString())=="OOO")
			  {
				color_sec_2_38="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_38%>'><%=dt.Rows[37][3]%></td>
  <%}%>
  <%
	 string color_sec_2_39="";
		if((dt.Rows[38][3].ToString())=="VD"||(dt.Rows[38][3].ToString())=="VC"||(dt.Rows[38][3].ToString())=="OC"||(dt.Rows[38][3].ToString())=="OD"||(dt.Rows[38][3].ToString())=="OOO")
		{
			if((dt.Rows[38][3].ToString())=="VD")
			  {
				color_sec_2_39="color:#E9D711";
			  }
			 if((dt.Rows[38][3].ToString())=="VC")
			 {
				color_sec_2_39="color:#3366ff";
			  }
			  if((dt.Rows[38][3].ToString())=="OC")
			  {
				color_sec_2_39="color:#0BC02C";
			  }
			 if((dt.Rows[38][3].ToString())=="OD")
			 {
				color_sec_2_39="color:#ff6600";
			  }
			  if((dt.Rows[38][3].ToString())=="OOO")
			  {
				color_sec_2_39="color:#ff0000";
			  }
          %>
  <td class=xl146 style='border-top:none;border-left:none;<%=color_sec_2_39%>'><%=dt.Rows[38][3]%></td>
  <%}%>
  <%
	 string color_sec_2_40="";
		if((dt.Rows[39][3].ToString())=="VD"||(dt.Rows[39][3].ToString())=="VC"||(dt.Rows[39][3].ToString())=="OC"||(dt.Rows[39][3].ToString())=="OD"||(dt.Rows[39][3].ToString())=="OOO")
		{
			if((dt.Rows[39][3].ToString())=="VD")
			  {
				color_sec_2_40="color:#E9D711";
			  }
			 if((dt.Rows[39][3].ToString())=="VC")
			 {
				color_sec_2_40="color:#3366ff";
			  }
			  if((dt.Rows[39][3].ToString())=="OC")
			  {
				color_sec_2_40="color:#0BC02C";
			  }
			 if((dt.Rows[39][3].ToString())=="OD")
			 {
				color_sec_2_40="color:#ff6600";
			  }
			  if((dt.Rows[39][3].ToString())=="OOO")
			  {
				color_sec_2_40="color:#ff0000";
			  }
          %>
  <td class=xl147 style='border-top:none;border-left:none;<%=color_sec_2_40%>'><%=dt.Rows[39][3]%></td>
  <%}%>
  <%
	 string color_sec_2_41="";
		if((dt.Rows[40][3].ToString())=="VD"||(dt.Rows[40][3].ToString())=="VC"||(dt.Rows[40][3].ToString())=="OC"||(dt.Rows[40][3].ToString())=="OD"||(dt.Rows[40][3].ToString())=="OOO")
		{
			if((dt.Rows[40][3].ToString())=="VD")
			  {
				color_sec_2_41="color:#E9D711";
			  }
			 if((dt.Rows[40][3].ToString())=="VC")
			 {
				color_sec_2_41="color:#3366ff";
			  }
			  if((dt.Rows[40][3].ToString())=="OC")
			  {
				color_sec_2_41="color:#0BC02C";
			  }
			 if((dt.Rows[40][3].ToString())=="OD")
			 {
				color_sec_2_41="color:#ff6600";
			  }
			  if((dt.Rows[40][3].ToString())=="OOO")
			  {
				color_sec_2_41="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_41%>'><%=dt.Rows[40][3]%></td>
  <%}%>
  <%
	 string color_sec_2_42="";
		if((dt.Rows[41][3].ToString())=="VD"||(dt.Rows[41][3].ToString())=="VC"||(dt.Rows[41][3].ToString())=="OC"||(dt.Rows[41][3].ToString())=="OD"||(dt.Rows[41][3].ToString())=="OOO")
		{
			if((dt.Rows[41][3].ToString())=="VD")
			  {
				color_sec_2_42="color:#E9D711";
			  }
			 if((dt.Rows[41][3].ToString())=="VC")
			 {
				color_sec_2_42="color:#3366ff";
			  }
			  if((dt.Rows[41][3].ToString())=="OC")
			  {
				color_sec_2_42="color:#0BC02C";
			  }
			 if((dt.Rows[41][3].ToString())=="OD")
			 {
				color_sec_2_42="color:#ff6600";
			  }
			  if((dt.Rows[41][3].ToString())=="OOO")
			  {
				color_sec_2_42="color:#ff0000";
			  }
          %>
  <td class=xl148 style='border-top:none;border-left:none;<%=color_sec_2_42%>'><%=dt.Rows[41][3]%></td>
  <%}%>
  <%
	 string color_sec_2_43="";
		if((dt.Rows[42][3].ToString())=="VD"||(dt.Rows[42][3].ToString())=="VC"||(dt.Rows[42][3].ToString())=="OC"||(dt.Rows[42][3].ToString())=="OD"||(dt.Rows[42][3].ToString())=="OOO")
		{
			if((dt.Rows[42][3].ToString())=="VD")
			  {
				color_sec_2_43="color:#E9D711";
			  }
			 if((dt.Rows[42][3].ToString())=="VC")
			 {
				color_sec_2_43="color:#3366ff";
			  }
			  if((dt.Rows[42][3].ToString())=="OC")
			  {
				color_sec_2_43="color:#0BC02C";
			  }
			 if((dt.Rows[42][3].ToString())=="OD")
			 {
				color_sec_2_43="color:#ff6600";
			  }
			  if((dt.Rows[42][3].ToString())=="OOO")
			  {
				color_sec_2_43="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_43%>'><%=dt.Rows[42][3]%></td>
  <%}%>
  <%
	 string color_sec_2_44="";
		if((dt.Rows[43][3].ToString())=="VD"||(dt.Rows[43][3].ToString())=="VC"||(dt.Rows[43][3].ToString())=="OC"||(dt.Rows[43][3].ToString())=="OD"||(dt.Rows[43][3].ToString())=="OOO")
		{
			if((dt.Rows[43][3].ToString())=="VD")
			  {
				color_sec_2_44="color:#E9D711";
			  }
			 if((dt.Rows[43][3].ToString())=="VC")
			 {
				color_sec_2_44="color:#3366ff";
			  }
			  if((dt.Rows[43][3].ToString())=="OC")
			  {
				color_sec_2_44="color:#0BC02C";
			  }
			 if((dt.Rows[43][3].ToString())=="OD")
			 {
				color_sec_2_44="color:#ff6600";
			  }
			  if((dt.Rows[43][3].ToString())=="OOO")
			  {
				color_sec_2_44="color:#ff0000";
			  }
          %>
  <td class=xl141 style='border-top:none;border-left:none;<%=color_sec_2_44%>'><%=dt.Rows[43][3]%></td>
  <%}%>
  <%
	 string color_sec_2_45="";
		if((dt.Rows[44][3].ToString())=="VD"||(dt.Rows[44][3].ToString())=="VC"||(dt.Rows[44][3].ToString())=="OC"||(dt.Rows[44][3].ToString())=="OD"||(dt.Rows[44][3].ToString())=="OOO")
		{
			if((dt.Rows[44][3].ToString())=="VD")
			  {
				color_sec_2_45="color:#E9D711";
			  }
			 if((dt.Rows[44][3].ToString())=="VC")
			 {
				color_sec_2_45="color:#3366ff";
			  }
			  if((dt.Rows[44][3].ToString())=="OC")
			  {
				color_sec_2_45="color:#0BC02C";
			  }
			 if((dt.Rows[44][3].ToString())=="OD")
			 {
				color_sec_2_45="color:#ff6600";
			  }
			  if((dt.Rows[44][3].ToString())=="OOO")
			  {
				color_sec_2_45="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl155 style='border-right:.5pt solid black;border-left:
  none;<%=color_sec_2_45%>'><%=dt.Rows[44][3]%></td>
  <%}%>
  <%
	 string color_sec_2_46="";
		if((dt.Rows[45][3].ToString())=="VD"||(dt.Rows[45][3].ToString())=="VC"||(dt.Rows[45][3].ToString())=="OC"||(dt.Rows[45][3].ToString())=="OD"||(dt.Rows[45][3].ToString())=="OOO")
		{
			if((dt.Rows[45][3].ToString())=="VD")
			  {
				color_sec_2_46="color:#E9D711";
			  }
			 if((dt.Rows[45][3].ToString())=="VC")
			 {
				color_sec_2_46="color:#3366ff";
			  }
			  if((dt.Rows[45][3].ToString())=="OC")
			  {
				color_sec_2_46="color:#0BC02C";
			  }
			 if((dt.Rows[45][3].ToString())=="OD")
			 {
				color_sec_2_46="color:#ff6600";
			  }
			  if((dt.Rows[45][3].ToString())=="OOO")
			  {
				color_sec_2_46="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl153 style='border-right:2.0pt double black;border-left:
  none;<%=color_sec_2_46%>'><%=dt.Rows[45][3]%></td>
  <%}%>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 class=xl178>V.C</td>
  <td class=xl136 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][4]%></td>
  <td colspan=50 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl102></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=6 class=xl71 style='height:13.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=12 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl179>V.D</td>
  <td class=xl135 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl180 style='height:14.25pt'>Fifth Floor</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=12 class=xl71 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl194>H.U</td>
  <td class=xl132 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][0]%></td>
  <td class=xl133 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][1]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][2]%></td>
  <td class=xl134 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][3]%></td>
  <td class=xl123 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl104 style='height:13.5pt;border-top:none'>501</td>
  <td class=xl69 style='border-top:none;border-left:none'>502</td>
  <td class=xl105 style='border-top:none'>503</td>
  <td class=xl69 style='border-left:none'>505</td>
  <td class=xl106 style='border-left:none'>506</td>
  <td class=xl69>507</td>
  <td class=xl107 style='border-left:none'>508</td>
  <td class=xl69 style='border-left:none'>509</td>
  <td colspan=2 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>510</td>
  <td colspan=2 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>511</td>
  <td class=xl107 style='border-left:none'>512</td>
  <td class=xl69 style='border-left:none'>515</td>
  <td colspan=2 class=xl160 style='border-right:.5pt solid black;border-left:
  none' x:num>516</td>
  <td colspan=2 class=xl164 style='border-right:2.0pt double black;border-left:
  none'>517</td>
  <td class=xl71>&nbsp;</td>
  <td colspan=2 class=xl195>Occupied %</td>
  <td class=xl137 style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][0]%></td>
  <td class=xl138 style='border-top:none;border-left:none' x:str><%=dt2.Rows[7][1]%></td>
  <td class=xl132 style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][2]%></td>
  <td class=xl132 style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][3]%></td>
  <td class=xl132 style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][4]%></td>
  <td colspan=51 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl108 style='height:13.5pt'><%=dt.Rows[46][1]%></td>
  <td class=xl78 style='border-left:none'><%=dt.Rows[47][1]%></td>
  <td class=xl75><%=dt.Rows[48][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[49][1]%></td>
  <td class=xl101 style='border-left:none'><%=dt.Rows[50][1]%></td>
  <td class=xl76><%=dt.Rows[51][1]%></td>
  <td class=xl109 style='border-left:none'><%=dt.Rows[52][1]%></td>
  <td class=xl77 style='border-left:none'><%=dt.Rows[53][1]%></td>
  <td colspan=2 class=xl152 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[54][1]%></td>
  <td colspan=2 class=xl152 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[55][1]%></td>
  <td class=xl110><%=dt.Rows[56][1]%></td>
  <td class=xl76 style='border-left:none'><%=dt.Rows[57][1]%></td>
  <td colspan=2 class=xl162 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[58][1]%></td>
  <td colspan=2 class=xl101 style='border-right:2.0pt double black;border-left:
  none'><%=dt.Rows[59][1]%></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=8 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=49 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=73 style='mso-height-source:userset;height:54.75pt'>
 <%
	 string color_sec_2_47="";
		if((dt.Rows[46][3].ToString())=="VD"||(dt.Rows[46][3].ToString())=="VC"||(dt.Rows[46][3].ToString())=="OC"||(dt.Rows[46][3].ToString())=="OD"||(dt.Rows[46][3].ToString())=="OOO")
		{
			if((dt.Rows[46][3].ToString())=="VD")
			  {
				color_sec_2_47="color:#E9D711";
			  }
			 if((dt.Rows[46][3].ToString())=="VC")
			 {
				color_sec_2_47="color:#3366ff";
			  }
			  if((dt.Rows[46][3].ToString())=="OC")
			  {
				color_sec_2_47="color:#0BC02C";
			  }
			 if((dt.Rows[46][3].ToString())=="OD")
			 {
				color_sec_2_47="color:#ff6600";
			  }
			  if((dt.Rows[46][3].ToString())=="OOO")
			  {
				color_sec_2_47="color:#ff0000";
			  }
          %>
  <td height=73 class=xl139 style='height:54.75pt;<%=color_sec_2_47%>'><%=dt.Rows[46][3]%></td>
  <%}%>
  <%
	 string color_sec_2_48="";
		if((dt.Rows[47][3].ToString())=="VD"||(dt.Rows[47][3].ToString())=="VC"||(dt.Rows[47][3].ToString())=="OC"||(dt.Rows[47][3].ToString())=="OD"||(dt.Rows[47][3].ToString())=="OOO")
		{
			if((dt.Rows[47][3].ToString())=="VD")
			  {
				color_sec_2_48="color:#E9D711";
			  }
			 if((dt.Rows[47][3].ToString())=="VC")
			 {
				color_sec_2_48="color:#3366ff";
			  }
			  if((dt.Rows[47][3].ToString())=="OC")
			  {
				color_sec_2_48="color:#0BC02C";
			  }
			 if((dt.Rows[47][3].ToString())=="OD")
			 {
				color_sec_2_48="color:#ff6600";
			  }
			  if((dt.Rows[47][3].ToString())=="OOO")
			  {
				color_sec_2_48="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_48%>'><%=dt.Rows[47][3]%></td>
  <%}%>
  <%
	 string color_sec_2_49="";
		if((dt.Rows[48][3].ToString())=="VD"||(dt.Rows[48][3].ToString())=="VC"||(dt.Rows[48][3].ToString())=="OC"||(dt.Rows[48][3].ToString())=="OD"||(dt.Rows[48][3].ToString())=="OOO")
		{
			if((dt.Rows[48][3].ToString())=="VD")
			  {
				color_sec_2_49="color:#E9D711";
			  }
			 if((dt.Rows[48][3].ToString())=="VC")
			 {
				color_sec_2_49="color:#3366ff";
			  }
			  if((dt.Rows[48][3].ToString())=="OC")
			  {
				color_sec_2_49="color:#0BC02C";
			  }
			 if((dt.Rows[48][3].ToString())=="OD")
			 {
				color_sec_2_49="color:#ff6600";
			  }
			  if((dt.Rows[48][3].ToString())=="OOO")
			  {
				color_sec_2_49="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_49%>'><%=dt.Rows[48][3]%></td>
  <%}%>
  <%
	 string color_sec_2_50="";
		if((dt.Rows[49][3].ToString())=="VD"||(dt.Rows[49][3].ToString())=="VC"||(dt.Rows[49][3].ToString())=="OC"||(dt.Rows[49][3].ToString())=="OD"||(dt.Rows[49][3].ToString())=="OOO")
		{
			if((dt.Rows[49][3].ToString())=="VD")
			  {
				color_sec_2_50="color:#E9D711";
			  }
			 if((dt.Rows[49][3].ToString())=="VC")
			 {
				color_sec_2_50="color:#3366ff";
			  }
			  if((dt.Rows[49][3].ToString())=="OC")
			  {
				color_sec_2_50="color:#0BC02C";
			  }
			 if((dt.Rows[49][3].ToString())=="OD")
			 {
				color_sec_2_50="color:#ff6600";
			  }
			  if((dt.Rows[49][3].ToString())=="OOO")
			  {
				color_sec_2_50="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_50%>'><%=dt.Rows[49][3]%></td>
  <%}%>
  <%
	 string color_sec_2_51="";
		if((dt.Rows[50][3].ToString())=="VD"||(dt.Rows[50][3].ToString())=="VC"||(dt.Rows[50][3].ToString())=="OC"||(dt.Rows[50][3].ToString())=="OD"||(dt.Rows[50][3].ToString())=="OOO")
		{
			if((dt.Rows[50][3].ToString())=="VD")
			  {
				color_sec_2_51="color:#E9D711";
			  }
			 if((dt.Rows[50][3].ToString())=="VC")
			 {
				color_sec_2_51="color:#3366ff";
			  }
			  if((dt.Rows[50][3].ToString())=="OC")
			  {
				color_sec_2_51="color:#0BC02C";
			  }
			 if((dt.Rows[50][3].ToString())=="OD")
			 {
				color_sec_2_51="color:#ff6600";
			  }
			  if((dt.Rows[50][3].ToString())=="OOO")
			  {
				color_sec_2_51="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_51%>'><%=dt.Rows[50][3]%></td>
  <%}%>
  <%
	 string color_sec_2_52="";
		if((dt.Rows[51][3].ToString())=="VD"||(dt.Rows[51][3].ToString())=="VC"||(dt.Rows[51][3].ToString())=="OC"||(dt.Rows[51][3].ToString())=="OD"||(dt.Rows[51][3].ToString())=="OOO")
		{
			if((dt.Rows[51][3].ToString())=="VD")
			  {
				color_sec_2_52="color:#E9D711";
			  }
			 if((dt.Rows[51][3].ToString())=="VC")
			 {
				color_sec_2_52="color:#3366ff";
			  }
			  if((dt.Rows[51][3].ToString())=="OC")
			  {
				color_sec_2_52="color:#0BC02C";
			  }
			 if((dt.Rows[51][3].ToString())=="OD")
			 {
				color_sec_2_52="color:#ff6600";
			  }
			  if((dt.Rows[51][3].ToString())=="OOO")
			  {
				color_sec_2_52="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_52%>'><%=dt.Rows[51][3]%></td>
  <%}%>
  <%
	 string color_sec_2_53="";
		if((dt.Rows[52][3].ToString())=="VD"||(dt.Rows[52][3].ToString())=="VC"||(dt.Rows[52][3].ToString())=="OC"||(dt.Rows[52][3].ToString())=="OD"||(dt.Rows[52][3].ToString())=="OOO")
		{
			if((dt.Rows[52][3].ToString())=="VD")
			  {
				color_sec_2_53="color:#E9D711";
			  }
			 if((dt.Rows[52][3].ToString())=="VC")
			 {
				color_sec_2_53="color:#3366ff";
			  }
			  if((dt.Rows[52][3].ToString())=="OC")
			  {
				color_sec_2_53="color:#0BC02C";
			  }
			 if((dt.Rows[52][3].ToString())=="OD")
			 {
				color_sec_2_53="color:#ff6600";
			  }
			  if((dt.Rows[52][3].ToString())=="OOO")
			  {
				color_sec_2_53="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_53%>'><%=dt.Rows[52][3]%></td>
  <%}%>
  <%
	 string color_sec_2_54="";
		if((dt.Rows[53][3].ToString())=="VD"||(dt.Rows[53][3].ToString())=="VC"||(dt.Rows[53][3].ToString())=="OC"||(dt.Rows[53][3].ToString())=="OD"||(dt.Rows[53][3].ToString())=="OOO")
		{
			if((dt.Rows[53][3].ToString())=="VD")
			  {
				color_sec_2_54="color:#E9D711";
			  }
			 if((dt.Rows[53][3].ToString())=="VC")
			 {
				color_sec_2_54="color:#3366ff";
			  }
			  if((dt.Rows[53][3].ToString())=="OC")
			  {
				color_sec_2_54="color:#0BC02C";
			  }
			 if((dt.Rows[53][3].ToString())=="OD")
			 {
				color_sec_2_54="color:#ff6600";
			  }
			  if((dt.Rows[53][3].ToString())=="OOO")
			  {
				color_sec_2_54="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_54%>'><%=dt.Rows[53][3]%></td>
  <%}%>
  <%
	 string color_sec_2_55="";
		if((dt.Rows[54][3].ToString())=="VD"||(dt.Rows[54][3].ToString())=="VC"||(dt.Rows[54][3].ToString())=="OC"||(dt.Rows[54][3].ToString())=="OD"||(dt.Rows[54][3].ToString())=="OOO")
		{
			if((dt.Rows[54][3].ToString())=="VD")
			  {
				color_sec_2_55="color:#E9D711";
			  }
			 if((dt.Rows[54][3].ToString())=="VC")
			 {
				color_sec_2_55="color:#3366ff";
			  }
			  if((dt.Rows[54][3].ToString())=="OC")
			  {
				color_sec_2_55="color:#0BC02C";
			  }
			 if((dt.Rows[54][3].ToString())=="OD")
			 {
				color_sec_2_55="color:#ff6600";
			  }
			  if((dt.Rows[54][3].ToString())=="OOO")
			  {
				color_sec_2_55="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl157 style='border-right:.5pt solid black;border-left:
  none;<%=color_sec_2_55%>'><%=dt.Rows[54][3]%></td>
  <%}%>
  <%
	 string color_sec_2_56="";
		if((dt.Rows[55][3].ToString())=="VD"||(dt.Rows[55][3].ToString())=="VC"||(dt.Rows[55][3].ToString())=="OC"||(dt.Rows[55][3].ToString())=="OD"||(dt.Rows[55][3].ToString())=="OOO")
		{
			if((dt.Rows[55][3].ToString())=="VD")
			  {
				color_sec_2_56="color:#E9D711";
			  }
			 if((dt.Rows[55][3].ToString())=="VC")
			 {
				color_sec_2_56="color:#3366ff";
			  }
			  if((dt.Rows[55][3].ToString())=="OC")
			  {
				color_sec_2_56="color:#0BC02C";
			  }
			 if((dt.Rows[55][3].ToString())=="OD")
			 {
				color_sec_2_56="color:#ff6600";
			  }
			  if((dt.Rows[55][3].ToString())=="OOO")
			  {
				color_sec_2_56="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl155 style='border-right:.5pt solid black;border-left:
  none;<%=color_sec_2_56%>'><%=dt.Rows[55][3]%></td>
  <%}%>
  <%
	 string color_sec_2_57="";
		if((dt.Rows[56][3].ToString())=="VD"||(dt.Rows[56][3].ToString())=="VC"||(dt.Rows[56][3].ToString())=="OC"||(dt.Rows[56][3].ToString())=="OD"||(dt.Rows[56][3].ToString())=="OOO")
		{
			if((dt.Rows[56][3].ToString())=="VD")
			  {
				color_sec_2_57="color:#E9D711";
			  }
			 if((dt.Rows[56][3].ToString())=="VC")
			 {
				color_sec_2_57="color:#3366ff";
			  }
			  if((dt.Rows[56][3].ToString())=="OC")
			  {
				color_sec_2_57="color:#0BC02C";
			  }
			 if((dt.Rows[56][3].ToString())=="OD")
			 {
				color_sec_2_57="color:#ff6600";
			  }
			  if((dt.Rows[56][3].ToString())=="OOO")
			  {
				color_sec_2_57="color:#ff0000";
			  }
          %>
  <td class=xl140 style='border-top:none;border-left:none;<%=color_sec_2_57%>'><%=dt.Rows[56][3]%></td>
  <%}%>
  <%
	 string color_sec_2_58="";
		if((dt.Rows[57][3].ToString())=="VD"||(dt.Rows[57][3].ToString())=="VC"||(dt.Rows[57][3].ToString())=="OC"||(dt.Rows[57][3].ToString())=="OD"||(dt.Rows[57][3].ToString())=="OOO")
		{
			if((dt.Rows[57][3].ToString())=="VD")
			  {
				color_sec_2_58="color:#E9D711";
			  }
			 if((dt.Rows[57][3].ToString())=="VC")
			 {
				color_sec_2_58="color:#3366ff";
			  }
			  if((dt.Rows[57][3].ToString())=="OC")
			  {
				color_sec_2_58="color:#0BC02C";
			  }
			 if((dt.Rows[57][3].ToString())=="OD")
			 {
				color_sec_2_58="color:#ff6600";
			  }
			  if((dt.Rows[57][3].ToString())=="OOO")
			  {
				color_sec_2_58="color:#ff0000";
			  }
          %>
  <td class=xl149 style='border-top:none;border-left:none;<%=color_sec_2_58%>'><%=dt.Rows[57][3]%></td>
  <%}%>
  <%
	 string color_sec_2_59="";
		if((dt.Rows[58][3].ToString())=="VD"||(dt.Rows[58][3].ToString())=="VC"||(dt.Rows[58][3].ToString())=="OC"||(dt.Rows[58][3].ToString())=="OD"||(dt.Rows[58][3].ToString())=="OOO")
		{
			if((dt.Rows[58][3].ToString())=="VD")
			  {
				color_sec_2_59="color:#E9D711";
			  }
			 if((dt.Rows[58][3].ToString())=="VC")
			 {
				color_sec_2_59="color:#3366ff";
			  }
			  if((dt.Rows[58][3].ToString())=="OC")
			  {
				color_sec_2_59="color:#0BC02C";
			  }
			 if((dt.Rows[58][3].ToString())=="OD")
			 {
				color_sec_2_59="color:#ff6600";
			  }
			  if((dt.Rows[58][3].ToString())=="OOO")
			  {
				color_sec_2_59="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl155 style='border-right:.5pt solid black;border-left:
  none;<%=color_sec_2_59%>'><%=dt.Rows[58][3]%></td>
  <%}%>
  <%
	 string color_sec_2_60="";
		if((dt.Rows[59][3].ToString())=="VD"||(dt.Rows[59][3].ToString())=="VC"||(dt.Rows[59][3].ToString())=="OC"||(dt.Rows[59][3].ToString())=="OD"||(dt.Rows[59][3].ToString())=="OOO")
		{
			if((dt.Rows[59][3].ToString())=="VD")
			  {
				color_sec_2_60="color:#E9D711";
			  }
			 if((dt.Rows[59][3].ToString())=="VC")
			 {
				color_sec_2_60="color:#3366ff";
			  }
			  if((dt.Rows[59][3].ToString())=="OC")
			  {
				color_sec_2_60="color:#0BC02C";
			  }
			 if((dt.Rows[59][3].ToString())=="OD")
			 {
				color_sec_2_60="color:#ff6600";
			  }
			  if((dt.Rows[59][3].ToString())=="OOO")
			  {
				color_sec_2_60="color:#ff0000";
			  }
          %>
  <td colspan=2 class=xl176 style='border-right:2.0pt double black;border-left:
  none;<%=color_sec_2_60%>'><%=dt.Rows[59][3]%></td>
  <%}%>
  <td class=xl111>&nbsp;</td>
  <td colspan=3 class=xl165 x:str="Checked by : ">Checked by :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=55 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=6 class=xl66 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=18 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl102 style='mso-ignore:colspan'></td>
  <td colspan=50 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl125></td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl98></td>
  <td colspan=63 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66><span style='mso-spacerun:yes'> </span></td>
  <td class=xl66></td>
  <td class=xl102></td>
  <td colspan=9 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl126></td>
  <td colspan=58 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=70 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=70 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=65 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=51 style='width:38pt'></td>
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
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
