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
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00170village_status");
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	DataTable dt2 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00170_village2");
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
<link rel=File-List href="rpt_htfo00170_Room_Status_Village_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_htfo00170_Room_Status_Village_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_htfo00170_Room_Status_Village_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Quyen</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-06-12T06:22:02Z</o:LastPrinted>
  <o:Created>2011-06-12T01:55:02Z</o:Created>
  <o:LastSaved>2011-06-12T06:23:10Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.32in .35in .27in .47in;
	mso-header-margin:.33in;
	mso-footer-margin:.28in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:136;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style22;
	color:#3366FF;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style22;
	color:green;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style22;
	color:purple;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style22;
	color:#3366FF;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	text-align:right;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style22;
	color:purple;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl64
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl65
	{mso-style-parent:style22;
	color:blue;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style22;
	color:red;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl68
	{mso-style-parent:style22;
	color:fuchsia;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl69
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style22;
	color:blue;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
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
	{mso-style-parent:style22;
	color:red;
	font-size:15.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style22;
	color:red;
	font-size:15.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style22;
	color:lime;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style22;
	color:#FF6600;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style22;
	color:#3366FF;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style22;
	color:#806517;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style22;
	color:teal;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl105
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style22;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style22;
	color:fuchsia;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style22;
	color:blue;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>22</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>17115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1149 style='border-collapse:
 collapse;table-layout:fixed;width:874pt'>
 <col width=46 span=12 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=46 span=12 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <tr height=94 style='mso-height-source:userset;height:70.5pt'>
  <td colspan=3 height=94 width=138 style='height:70.5pt;width:105pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:3.75pt;margin-top:2.25pt;width:128.25pt;height:66pt;z-index:1'>
   <v:imagedata src="rpt_htfo00170_Room_Status_Village_files/image001.png"
    o:title="Songgia"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:5px;margin-top:3px;width:171px;
  height:88px'><img width=171 height=88
  src="rpt_htfo00170_Room_Status_Village_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=94 class=xl103 width=138 style='height:70.5pt;
    width:105pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl76 width=46 style='width:35pt'>&nbsp;</td>
  <td colspan=16 class=xl84 width=735 style='width:559pt'>Daily SRA Room
  Stastus Report</td>
  <td colspan=2 class=xl90 width=92 style='width:70pt'>Last updated:</td>
  <td colspan=3 class=xl90 width=138 style='width:105pt'><%=l_print_date%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=12 height=30 class=xl104 style='height:22.5pt'>Block A1</td>
  <td class=xl51 style='border-top:none'>&nbsp;</td>
  <td colspan=12 class=xl108 style='border-right:1.0pt solid black'>Block A8</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl52 style='height:18.0pt;border-top:none'>101</td>
  <td class=xl49 style='border-top:none;border-left:none'>102</td>
  <td class=xl48 style='border-top:none;border-left:none'>103</td>
  <td class=xl49 style='border-top:none;border-left:none'>104</td>
  <td class=xl48 style='border-top:none;border-left:none'>201</td>
  <td class=xl49 style='border-top:none;border-left:none'>202</td>
  <td class=xl48 style='border-top:none;border-left:none'>203</td>
  <td class=xl49 style='border-top:none;border-left:none'>204</td>
  <td class=xl48 style='border-top:none;border-left:none'>301</td>
  <td class=xl49 style='border-top:none;border-left:none'>302</td>
  <td class=xl48 style='border-top:none;border-left:none'>303</td>
  <td class=xl49 style='border-top:none;border-left:none'>304</td>
  <td></td>
  <td class=xl27>101</td>
  <td class=xl27 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl27 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td class=xl39></td>
  <td class=xl40></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl54 style='height:18.0pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td></td>
  <td class=xl28 style='border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl55>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_0="";
		if((dt.Rows[0][3].ToString())!="")
		{
			if((dt.Rows[0][3].ToString())=="VD")
			  {
				color_sec_0="color:#806517";// 806517
			  }
			 if((dt.Rows[0][3].ToString())=="VC")  
			 {
				color_sec_0="color:#3366ff";
			  }
			  if((dt.Rows[0][3].ToString())=="OC")
			  {
				color_sec_0="color:#0BC02C";
			  }
			 if((dt.Rows[0][3].ToString())=="OD")
			 {
				color_sec_0="color:#ff6600";
			  }
			  if((dt.Rows[0][3].ToString())=="OOO")
			  {
				color_sec_0="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_0%>'><%=dt.Rows[0][3]%></td>
  <%}%>
  <%
	 string color_sec_1="";
		if((dt.Rows[1][3].ToString())!="")
		{
			if((dt.Rows[1][3].ToString())=="VD")
			  {
				color_sec_1="color:#806517";
			  }
			 if((dt.Rows[1][3].ToString())=="VC")
			 {
				color_sec_1="color:#3366ff";
			  }
			  if((dt.Rows[1][3].ToString())=="OC")
			  {
				color_sec_1="color:#0BC02C";
			  }
			 if((dt.Rows[1][3].ToString())=="OD")
			 {
				color_sec_1="color:#ff6600";
			  }
			  if((dt.Rows[1][3].ToString())=="OOO")
			  {
				color_sec_1="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_1%>'><%=dt.Rows[1][3]%></td>
  <%}%>
  <%
	 string color_sec_2="";
		if((dt.Rows[2][3].ToString())!="")
		{
			if((dt.Rows[2][3].ToString())=="VD")
			  {
				color_sec_2="color:#806517";
			  }
			 if((dt.Rows[2][3].ToString())=="VC")
			 {
				color_sec_2="color:#3366ff";
			  }
			  if((dt.Rows[2][3].ToString())=="OC")
			  {
				color_sec_2="color:#0BC02C";
			  }
			 if((dt.Rows[2][3].ToString())=="OD")
			 {
				color_sec_2="color:#ff6600";
			  }
			  if((dt.Rows[2][3].ToString())=="OOO")
			  {
				color_sec_2="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_2%>'><%=dt.Rows[2][3]%></td>
  <%}%>
  <%
	 string color_sec_3="";
		if((dt.Rows[3][3].ToString())!="")
		{
			if((dt.Rows[3][3].ToString())=="VD")
			  {
				color_sec_3="color:#806517";
			  }
			 if((dt.Rows[3][3].ToString())=="VC")
			 {
				color_sec_3="color:#3366ff";
			  }
			  if((dt.Rows[3][3].ToString())=="OC")
			  {
				color_sec_3="color:#0BC02C";
			  }
			 if((dt.Rows[3][3].ToString())=="OD")
			 {
				color_sec_3="color:#ff6600";
			  }
			  if((dt.Rows[3][3].ToString())=="OOO")
			  {
				color_sec_3="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_3%>'><%=dt.Rows[3][3]%></td>
  <%}%>
  <%
	 string color_sec_4="";
		if((dt.Rows[4][3].ToString())!="")
		{
			if((dt.Rows[4][3].ToString())=="VD")
			  {
				color_sec_4="color:#806517";
			  }
			 if((dt.Rows[4][3].ToString())=="VC")
			 {
				color_sec_4="color:#3366ff";
			  }
			  if((dt.Rows[4][3].ToString())=="OC")
			  {
				color_sec_4="color:#0BC02C";
			  }
			 if((dt.Rows[4][3].ToString())=="OD")
			 {
				color_sec_4="color:#ff6600";
			  }
			  if((dt.Rows[4][3].ToString())=="OOO")
			  {
				color_sec_4="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_4%>'><%=dt.Rows[4][3]%></td>
  <%}%>
  <%
	 string color_sec_5="";
		if((dt.Rows[5][3].ToString())!="")
		{
			if((dt.Rows[5][3].ToString())=="VD")
			  {
				color_sec_5="color:#806517";
			  }
			 if((dt.Rows[5][3].ToString())=="VC")
			 {
				color_sec_5="color:#3366ff";
			  }
			  if((dt.Rows[5][3].ToString())=="OC")
			  {
				color_sec_5="color:#0BC02C";
			  }
			 if((dt.Rows[5][3].ToString())=="OD")
			 {
				color_sec_5="color:#ff6600";
			  }
			  if((dt.Rows[5][3].ToString())=="OOO")
			  {
				color_sec_5="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_5%>'><%=dt.Rows[5][3]%></td>
  <%}%>
  <%
	 string color_sec_6="";
		if((dt.Rows[6][3].ToString())!="")
		{
			if((dt.Rows[6][3].ToString())=="VD")
			  {
				color_sec_6="color:#806517";
			  }
			 if((dt.Rows[6][3].ToString())=="VC")
			 {
				color_sec_6="color:#3366ff";
			  }
			  if((dt.Rows[6][3].ToString())=="OC")
			  {
				color_sec_6="color:#0BC02C";
			  }
			 if((dt.Rows[6][3].ToString())=="OD")
			 {
				color_sec_6="color:#ff6600";
			  }
			  if((dt.Rows[6][3].ToString())=="OOO")
			  {
				color_sec_6="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_6%>'><%=dt.Rows[6][3]%></td>
  <%}%>
  <%
	 string color_sec_7="";
		if((dt.Rows[7][3].ToString())!="")
		{
			if((dt.Rows[7][3].ToString())=="VD")
			  {
				color_sec_7="color:#806517";
			  }
			 if((dt.Rows[7][3].ToString())=="VC")
			 {
				color_sec_7="color:#3366ff";
			  }
			  if((dt.Rows[7][3].ToString())=="OC")
			  {
				color_sec_7="color:#0BC02C";
			  }
			 if((dt.Rows[7][3].ToString())=="OD")
			 {
				color_sec_7="color:#ff6600";
			  }
			  if((dt.Rows[7][3].ToString())=="OOO")
			  {
				color_sec_7="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_7%>'><%=dt.Rows[7][3]%></td>
  <%}%>
  <%
	 string color_sec_8="";
		if((dt.Rows[8][3].ToString())!="")
		{
			if((dt.Rows[8][3].ToString())=="VD")
			  {
				color_sec_8="color:#806517";
			  }
			 if((dt.Rows[8][3].ToString())=="VC")
			 {
				color_sec_8="color:#3366ff";
			  }
			  if((dt.Rows[8][3].ToString())=="OC")
			  {
				color_sec_8="color:#0BC02C";
			  }
			 if((dt.Rows[8][3].ToString())=="OD")
			 {
				color_sec_8="color:#ff6600";
			  }
			  if((dt.Rows[8][3].ToString())=="OOO")
			  {
				color_sec_8="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_8%>'><%=dt.Rows[8][3]%></td>
  <%}%>
  <%
	 string color_sec_9="";
		if((dt.Rows[9][3].ToString())!="")
		{
			if((dt.Rows[9][3].ToString())=="VD")
			  {
				color_sec_9="color:#806517";
			  }
			 if((dt.Rows[9][3].ToString())=="VC")
			 {
				color_sec_9="color:#3366ff";
			  }
			  if((dt.Rows[9][3].ToString())=="OC")
			  {
				color_sec_9="color:#0BC02C";
			  }
			 if((dt.Rows[9][3].ToString())=="OD")
			 {
				color_sec_9="color:#ff6600";
			  }
			  if((dt.Rows[9][3].ToString())=="OOO")
			  {
				color_sec_9="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_9%>'><%=dt.Rows[9][3]%></td>
  <%}%>
  <%
	 string color_sec_10="";
		if((dt.Rows[10][3].ToString())!="")
		{
			if((dt.Rows[10][3].ToString())=="VD")
			  {
				color_sec_10="color:#806517";
			  }
			 if((dt.Rows[10][3].ToString())=="VC")
			 {
				color_sec_10="color:#3366ff";
			  }
			  if((dt.Rows[10][3].ToString())=="OC")
			  {
				color_sec_10="color:#0BC02C";
			  }
			 if((dt.Rows[10][3].ToString())=="OD")
			 {
				color_sec_10="color:#ff6600";
			  }
			  if((dt.Rows[10][3].ToString())=="OOO")
			  {
				color_sec_10="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_10%>'><%=dt.Rows[10][3]%></td>
  <%}%>
  <%
	 string color_sec_11="";
		if((dt.Rows[11][3].ToString())!="")
		{
			if((dt.Rows[11][3].ToString())=="VD")
			  {
				color_sec_11="color:#806517";
			  }
			 if((dt.Rows[11][3].ToString())=="VC")
			 {
				color_sec_11="color:#3366ff";
			  }
			  if((dt.Rows[11][3].ToString())=="OC")
			  {
				color_sec_11="color:#0BC02C";
			  }
			 if((dt.Rows[11][3].ToString())=="OD")
			 {
				color_sec_11="color:#ff6600";
			  }
			  if((dt.Rows[11][3].ToString())=="OOO")
			  {
				color_sec_11="color:#ff0000";//end Block A1
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_11%>'><%=dt.Rows[11][3]%></td>
  <%}%>
  <td></td>
  <%
	 string color_sec_54=""; //begin Block A8
		if((dt.Rows[54][3].ToString())!="")
		{
			if((dt.Rows[54][3].ToString())=="VD")
			  {
				color_sec_54="color:#806517";
			  }
			 if((dt.Rows[54][3].ToString())=="VC")
			 {
				color_sec_54="color:#3366ff";
			  }
			  if((dt.Rows[54][3].ToString())=="OC")
			  {
				color_sec_54="color:#0BC02C";
			  }
			 if((dt.Rows[54][3].ToString())=="OD")
			 {
				color_sec_54="color:#ff6600";
			  }
			  if((dt.Rows[54][3].ToString())=="OOO")
			  {
				color_sec_54="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_54%>'><%=dt.Rows[54][3]%></td>
  <%}%>
  <%
	 string color_sec_55="";
		if((dt.Rows[55][3].ToString())!="")
		{
			if((dt.Rows[55][3].ToString())=="VD")
			  {
				color_sec_55="color:#806517";
			  }
			 if((dt.Rows[55][3].ToString())=="VC")
			 {
				color_sec_55="color:#3366ff";
			  }
			  if((dt.Rows[55][3].ToString())=="OC")
			  {
				color_sec_55="color:#0BC02C";
			  }
			 if((dt.Rows[55][3].ToString())=="OD")
			 {
				color_sec_55="color:#ff6600";
			  }
			  if((dt.Rows[55][3].ToString())=="OOO")
			  {
				color_sec_55="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_55%>'><%=dt.Rows[55][3]%></td>
  <%}%>
  <%
	 string color_sec_56="";
		if((dt.Rows[56][3].ToString())!="")
		{
			if((dt.Rows[56][3].ToString())=="VD")
			  {
				color_sec_56="color:#806517";
			  }
			 if((dt.Rows[56][3].ToString())=="VC")
			 {
				color_sec_56="color:#3366ff";
			  }
			  if((dt.Rows[56][3].ToString())=="OC")
			  {
				color_sec_56="color:#0BC02C";
			  }
			 if((dt.Rows[56][3].ToString())=="OD")
			 {
				color_sec_56="color:#ff6600";
			  }
			  if((dt.Rows[56][3].ToString())=="OOO")
			  {
				color_sec_56="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_56%>'><%=dt.Rows[56][3]%></td>
  <%}%>
  <%
	 string color_sec_57="";
		if((dt.Rows[57][3].ToString())!="")
		{
			if((dt.Rows[57][3].ToString())=="VD")
			  {
				color_sec_57="color:#806517";
			  }
			 if((dt.Rows[57][3].ToString())=="VC")
			 {
				color_sec_57="color:#3366ff";
			  }
			  if((dt.Rows[57][3].ToString())=="OC")
			  {
				color_sec_57="color:#0BC02C";
			  }
			 if((dt.Rows[57][3].ToString())=="OD")
			 {
				color_sec_57="color:#ff6600";
			  }
			  if((dt.Rows[57][3].ToString())=="OOO")
			  {
				color_sec_57="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_57%>'><%=dt.Rows[57][3]%></td>
  <%}%>
  <%
	 string color_sec_58="";
		if((dt.Rows[58][3].ToString())!="")
		{
			if((dt.Rows[58][3].ToString())=="VD")
			  {
				color_sec_58="color:#806517";
			  }
			 if((dt.Rows[58][3].ToString())=="VC")
			 {
				color_sec_58="color:#3366ff";
			  }
			  if((dt.Rows[58][3].ToString())=="OC")
			  {
				color_sec_58="color:#0BC02C";
			  }
			 if((dt.Rows[58][3].ToString())=="OD")
			 {
				color_sec_58="color:#ff6600";
			  }
			  if((dt.Rows[58][3].ToString())=="OOO")
			  {
				color_sec_58="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_58%>'><%=dt.Rows[58][3]%></td>
  <%}%>
  <%
	 string color_sec_59="";
		if((dt.Rows[59][3].ToString())!="")
		{
			if((dt.Rows[59][3].ToString())=="VD")
			  {
				color_sec_59="color:#806517";
			  }
			 if((dt.Rows[59][3].ToString())=="VC")
			 {
				color_sec_59="color:#3366ff";
			  }
			  if((dt.Rows[59][3].ToString())=="OC")
			  {
				color_sec_59="color:#0BC02C";
			  }
			 if((dt.Rows[59][3].ToString())=="OD")
			 {
				color_sec_59="color:#ff6600";
			  }
			  if((dt.Rows[59][3].ToString())=="OOO")
			  {
				color_sec_59="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_59%>'><%=dt.Rows[59][3]%></td>
  <%}%>
  <td class=xl44></td>
  <td class=xl45></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=12 height=32 class=xl106 style='height:24.0pt'>Block A2</td>
  <td></td>
  <td colspan=12 class=xl107 style='border-right:1.0pt solid black'>Block A9</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt;border-top:none'>101</td>
  <td class=xl26 style='border-top:none;border-left:none'>102</td>
  <td class=xl27 style='border-top:none;border-left:none'>103</td>
  <td class=xl26 style='border-top:none;border-left:none'>104</td>
  <td class=xl27 style='border-top:none;border-left:none'>201</td>
  <td class=xl26 style='border-top:none;border-left:none'>202</td>
  <td class=xl27 style='border-top:none;border-left:none'>203</td>
  <td class=xl26 style='border-top:none;border-left:none'>204</td>
  <td class=xl27 style='border-top:none;border-left:none'>301</td>
  <td class=xl26 style='border-top:none;border-left:none'>302</td>
  <td class=xl27 style='border-top:none;border-left:none'>303</td>
  <td class=xl26 style='border-top:none;border-left:none'>304</td>
  <td></td>
  <td class=xl27 style='border-top:none'>101</td>
  <td class=xl27 style='border-top:none;border-left:none'>102</td>
  <td class=xl27 style='border-top:none;border-left:none'>103</td>
  <td class=xl27 style='border-top:none;border-left:none'>104</td>
  <td class=xl27 style='border-top:none;border-left:none'>201</td>
  <td class=xl26 style='border-top:none;border-left:none'>202</td>
  <td class=xl27 style='border-top:none;border-left:none'>203</td>
  <td class=xl26 style='border-top:none;border-left:none'>204</td>
  <td class=xl27 style='border-top:none;border-left:none'>301</td>
  <td class=xl27 style='border-top:none;border-left:none'>302</td>
  <td class=xl26 style='border-top:none;border-left:none'>303</td>
  <td class=xl59 style='border-top:none;border-left:none'>304</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl54 style='height:18.0pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td></td>
  <td class=xl28 style='border-top:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl60 style='border-top:none;border-left:none'>A110</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_12="";
		if((dt.Rows[12][3].ToString())!="")
		{
			if((dt.Rows[12][3].ToString())=="VD")
			  {
				color_sec_12="color:#806517";
			  }
			 if((dt.Rows[12][3].ToString())=="VC")
			 {
				color_sec_12="color:#3366ff";
			  }
			  if((dt.Rows[12][3].ToString())=="OC")
			  {
				color_sec_12="color:#0BC02C";
			  }
			 if((dt.Rows[12][3].ToString())=="OD")
			 {
				color_sec_12="color:#ff6600";
			  }
			  if((dt.Rows[12][3].ToString())=="OOO")
			  {
				color_sec_12="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_12%>'><%=dt.Rows[12][3]%></td>
  <%}%>
  <%
	 string color_sec_13="";
		if((dt.Rows[13][3].ToString())!="")
		{
			if((dt.Rows[13][3].ToString())=="VD")
			  {
				color_sec_13="color:#806517";
			  }
			 if((dt.Rows[13][3].ToString())=="VC")
			 {
				color_sec_13="color:#3366ff";
			  }
			  if((dt.Rows[13][3].ToString())=="OC")
			  {
				color_sec_13="color:#0BC02C";
			  }
			 if((dt.Rows[13][3].ToString())=="OD")
			 {
				color_sec_13="color:#ff6600";
			  }
			  if((dt.Rows[13][3].ToString())=="OOO")
			  {
				color_sec_13="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_13%>'><%=dt.Rows[13][3]%></td>
  <%}%>
  <%
	 string color_sec_14="";
		if((dt.Rows[14][3].ToString())!="")
		{
			if((dt.Rows[14][3].ToString())=="VD")
			  {
				color_sec_14="color:#806517";
			  }
			 if((dt.Rows[14][3].ToString())=="VC")
			 {
				color_sec_14="color:#3366ff";
			  }
			  if((dt.Rows[14][3].ToString())=="OC")
			  {
				color_sec_14="color:#0BC02C";
			  }
			 if((dt.Rows[14][3].ToString())=="OD")
			 {
				color_sec_14="color:#ff6600";
			  }
			  if((dt.Rows[14][3].ToString())=="OOO")
			  {
				color_sec_14="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_14%>'><%=dt.Rows[14][3]%></td>
  <%}%>
  <%
	 string color_sec_15="";
		if((dt.Rows[15][3].ToString())!="")
		{
			if((dt.Rows[15][3].ToString())=="VD")
			  {
				color_sec_15="color:#806517";
			  }
			 if((dt.Rows[15][3].ToString())=="VC")
			 {
				color_sec_15="color:#3366ff";
			  }
			  if((dt.Rows[15][3].ToString())=="OC")
			  {
				color_sec_15="color:#0BC02C";
			  }
			 if((dt.Rows[15][3].ToString())=="OD")
			 {
				color_sec_15="color:#ff6600";
			  }
			  if((dt.Rows[15][3].ToString())=="OOO")
			  {
				color_sec_15="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_15%>'><%=dt.Rows[15][3]%></td>
  <%}%>
  <%
	 string color_sec_16="";
		if((dt.Rows[16][3].ToString())!="")
		{
			if((dt.Rows[16][3].ToString())=="VD")
			  {
				color_sec_16="color:#806517";
			  }
			 if((dt.Rows[16][3].ToString())=="VC")
			 {
				color_sec_16="color:#3366ff";
			  }
			  if((dt.Rows[16][3].ToString())=="OC")
			  {
				color_sec_16="color:#0BC02C";
			  }
			 if((dt.Rows[16][3].ToString())=="OD")
			 {
				color_sec_16="color:#ff6600";
			  }
			  if((dt.Rows[16][3].ToString())=="OOO")
			  {
				color_sec_16="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_16%>'><%=dt.Rows[16][3]%></td>
  <%}%>
  <%
	 string color_sec_17="";
		if((dt.Rows[17][3].ToString())!="")
		{
			if((dt.Rows[17][3].ToString())=="VD")
			  {
				color_sec_17="color:#806517";
			  }
			 if((dt.Rows[17][3].ToString())=="VC")
			 {
				color_sec_17="color:#3366ff";
			  }
			  if((dt.Rows[17][3].ToString())=="OC")
			  {
				color_sec_17="color:#0BC02C";
			  }
			 if((dt.Rows[17][3].ToString())=="OD")
			 {
				color_sec_17="color:#ff6600";
			  }
			  if((dt.Rows[17][3].ToString())=="OOO")
			  {
				color_sec_17="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_17%>'><%=dt.Rows[17][3]%></td>
  <%}%>
  <%
	 string color_sec_18="";
		if((dt.Rows[18][3].ToString())!="")
		{
			if((dt.Rows[18][3].ToString())=="VD")
			  {
				color_sec_18="color:#806517";
			  }
			 if((dt.Rows[18][3].ToString())=="VC")
			 {
				color_sec_18="color:#3366ff";
			  }
			  if((dt.Rows[18][3].ToString())=="OC")
			  {
				color_sec_18="color:#0BC02C";
			  }
			 if((dt.Rows[18][3].ToString())=="OD")
			 {
				color_sec_18="color:#ff6600";
			  }
			  if((dt.Rows[18][3].ToString())=="OOO")
			  {
				color_sec_18="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_18%>'><%=dt.Rows[18][3]%></td>
  <%}%>
  <%
	 string color_sec_19="";
		if((dt.Rows[19][3].ToString())!="")
		{
			if((dt.Rows[19][3].ToString())=="VD")
			  {
				color_sec_19="color:#806517";
			  }
			 if((dt.Rows[19][3].ToString())=="VC")
			 {
				color_sec_19="color:#3366ff";
			  }
			  if((dt.Rows[19][3].ToString())=="OC")
			  {
				color_sec_19="color:#0BC02C";
			  }
			 if((dt.Rows[19][3].ToString())=="OD")
			 {
				color_sec_19="color:#ff6600";
			  }
			  if((dt.Rows[19][3].ToString())=="OOO")
			  {
				color_sec_19="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_19%>'><%=dt.Rows[19][3]%></td>
  <%}%>
  <%
	 string color_sec_20="";
		if((dt.Rows[20][3].ToString())!="")
		{
			if((dt.Rows[20][3].ToString())=="VD")
			  {
				color_sec_20="color:#806517";
			  }
			 if((dt.Rows[20][3].ToString())=="VC")
			 {
				color_sec_20="color:#3366ff";
			  }
			  if((dt.Rows[20][3].ToString())=="OC")
			  {
				color_sec_20="color:#0BC02C";
			  }
			 if((dt.Rows[20][3].ToString())=="OD")
			 {
				color_sec_20="color:#ff6600";
			  }
			  if((dt.Rows[20][3].ToString())=="OOO")
			  {
				color_sec_20="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_20%>'><%=dt.Rows[20][3]%></td>
  <%}%>
  <%
	 string color_sec_21="";
		if((dt.Rows[21][3].ToString())!="")
		{
			if((dt.Rows[21][3].ToString())=="VD")
			  {
				color_sec_21="color:#806517";
			  }
			 if((dt.Rows[21][3].ToString())=="VC")
			 {
				color_sec_21="color:#3366ff";
			  }
			  if((dt.Rows[21][3].ToString())=="OC")
			  {
				color_sec_21="color:#0BC02C";
			  }
			 if((dt.Rows[21][3].ToString())=="OD")
			 {
				color_sec_21="color:#ff6600";
			  }
			  if((dt.Rows[21][3].ToString())=="OOO")
			  {
				color_sec_21="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_21%>'><%=dt.Rows[21][3]%></td>
  <%}%>
  <%
	 string color_sec_22="";
		if((dt.Rows[22][3].ToString())!="")
		{
			if((dt.Rows[22][3].ToString())=="VD")
			  {
				color_sec_22="color:#806517";
			  }
			 if((dt.Rows[22][3].ToString())=="VC")
			 {
				color_sec_22="color:#3366ff";
			  }
			  if((dt.Rows[22][3].ToString())=="OC")
			  {
				color_sec_22="color:#0BC02C";
			  }
			 if((dt.Rows[22][3].ToString())=="OD")
			 {
				color_sec_22="color:#ff6600";
			  }
			  if((dt.Rows[22][3].ToString())=="OOO")
			  {
				color_sec_22="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_22%>'><%=dt.Rows[22][3]%></td>
  <%}%>
  <%
	 string color_sec_23="";
		if((dt.Rows[23][3].ToString())!="")
		{
			if((dt.Rows[23][3].ToString())=="VD")
			  {
				color_sec_23="color:#806517";
			  }
			 if((dt.Rows[23][3].ToString())=="VC")
			 {
				color_sec_23="color:#3366ff";
			  }
			  if((dt.Rows[23][3].ToString())=="OC")
			  {
				color_sec_23="color:#0BC02C";
			  }
			 if((dt.Rows[23][3].ToString())=="OD")
			 {
				color_sec_23="color:#ff6600";
			  }
			  if((dt.Rows[23][3].ToString())=="OOO")
			  {
				color_sec_23="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_23%>'><%=dt.Rows[23][3]%></td>
  <%}%>
  <td></td>
  <%
	 string color_sec_60="";
		if((dt.Rows[60][3].ToString())!="")
		{
			if((dt.Rows[60][3].ToString())=="VD")
			  {
				color_sec_60="color:#806517";
			  }
			 if((dt.Rows[60][3].ToString())=="VC")
			 {
				color_sec_60="color:#3366ff";
			  }
			  if((dt.Rows[60][3].ToString())=="OC")
			  {
				color_sec_60="color:#0BC02C";
			  }
			 if((dt.Rows[60][3].ToString())=="OD")
			 {
				color_sec_60="color:#ff6600";
			  }
			  if((dt.Rows[60][3].ToString())=="OOO")
			  {
				color_sec_60="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_60%>'><%=dt.Rows[60][3]%></td>
  <%}%>
  <%
	 string color_sec_61="";
		if((dt.Rows[61][3].ToString())!="")
		{
			if((dt.Rows[61][3].ToString())=="VD")
			  {
				color_sec_61="color:#806517";
			  }
			 if((dt.Rows[61][3].ToString())=="VC")
			 {
				color_sec_61="color:#3366ff";
			  }
			  if((dt.Rows[61][3].ToString())=="OC")
			  {
				color_sec_61="color:#0BC02C";
			  }
			 if((dt.Rows[61][3].ToString())=="OD")
			 {
				color_sec_61="color:#ff6600";
			  }
			  if((dt.Rows[61][3].ToString())=="OOO")
			  {
				color_sec_61="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_61%>'><%=dt.Rows[61][3]%></td>
  <%}%>
  <%
	 string color_sec_62="";
		if((dt.Rows[62][3].ToString())!="")
		{
			if((dt.Rows[62][3].ToString())=="VD")
			  {
				color_sec_62="color:#806517";
			  }
			 if((dt.Rows[62][3].ToString())=="VC")
			 {
				color_sec_62="color:#3366ff";
			  }
			  if((dt.Rows[62][3].ToString())=="OC")
			  {
				color_sec_62="color:#0BC02C";
			  }
			 if((dt.Rows[62][3].ToString())=="OD")
			 {
				color_sec_62="color:#ff6600";
			  }
			  if((dt.Rows[62][3].ToString())=="OOO")
			  {
				color_sec_62="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_62%>'><%=dt.Rows[62][3]%></td>
  <%}%>
  <%
	 string color_sec_63="";
		if((dt.Rows[63][3].ToString())!="")
		{
			if((dt.Rows[63][3].ToString())=="VD")
			  {
				color_sec_63="color:#806517";
			  }
			 if((dt.Rows[63][3].ToString())=="VC")
			 {
				color_sec_63="color:#3366ff";
			  }
			  if((dt.Rows[63][3].ToString())=="OC")
			  {
				color_sec_63="color:#0BC02C";
			  }
			 if((dt.Rows[63][3].ToString())=="OD")
			 {
				color_sec_63="color:#ff6600";
			  }
			  if((dt.Rows[63][3].ToString())=="OOO")
			  {
				color_sec_63="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_63%>'><%=dt.Rows[63][3]%></td>
  <%}%>
  <%
	 string color_sec_64="";
		if((dt.Rows[64][3].ToString())!="")
		{
			if((dt.Rows[64][3].ToString())=="VD")
			  {
				color_sec_64="color:#806517";
			  }
			 if((dt.Rows[64][3].ToString())=="VC")
			 {
				color_sec_64="color:#3366ff";
			  }
			  if((dt.Rows[64][3].ToString())=="OC")
			  {
				color_sec_64="color:#0BC02C";
			  }
			 if((dt.Rows[64][3].ToString())=="OD")
			 {
				color_sec_64="color:#ff6600";
			  }
			  if((dt.Rows[64][3].ToString())=="OOO")
			  {
				color_sec_64="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_64%>'><%=dt.Rows[64][3]%></td>
  <%}%>
  <%
	 string color_sec_65="";
		if((dt.Rows[65][3].ToString())!="")
		{
			if((dt.Rows[65][3].ToString())=="VD")
			  {
				color_sec_65="color:#806517";
			  }
			 if((dt.Rows[65][3].ToString())=="VC")
			 {
				color_sec_65="color:#3366ff";
			  }
			  if((dt.Rows[65][3].ToString())=="OC")
			  {
				color_sec_65="color:#0BC02C";
			  }
			 if((dt.Rows[65][3].ToString())=="OD")
			 {
				color_sec_65="color:#ff6600";
			  }
			  if((dt.Rows[65][3].ToString())=="OOO")
			  {
				color_sec_65="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_65%>'><%=dt.Rows[65][3]%></td>
  <%}%>
  <%
	 string color_sec_66="";
		if((dt.Rows[66][3].ToString())!="")
		{
			if((dt.Rows[66][3].ToString())=="VD")
			  {
				color_sec_66="color:#806517";
			  }
			 if((dt.Rows[66][3].ToString())=="VC")
			 {
				color_sec_66="color:#3366ff";
			  }
			  if((dt.Rows[66][3].ToString())=="OC")
			  {
				color_sec_66="color:#0BC02C";
			  }
			 if((dt.Rows[66][3].ToString())=="OD")
			 {
				color_sec_66="color:#ff6600";
			  }
			  if((dt.Rows[66][3].ToString())=="OOO")
			  {
				color_sec_66="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_66%>'><%=dt.Rows[66][3]%></td>
  <%}%>
  <%
	 string color_sec_67="";
		if((dt.Rows[67][3].ToString())!="")
		{
			if((dt.Rows[67][3].ToString())=="VD")
			  {
				color_sec_67="color:#806517";
			  }
			 if((dt.Rows[67][3].ToString())=="VC")
			 {
				color_sec_67="color:#3366ff";
			  }
			  if((dt.Rows[67][3].ToString())=="OC")
			  {
				color_sec_67="color:#0BC02C";
			  }
			 if((dt.Rows[67][3].ToString())=="OD")
			 {
				color_sec_67="color:#ff6600";
			  }
			  if((dt.Rows[67][3].ToString())=="OOO")
			  {
				color_sec_67="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_67%>'><%=dt.Rows[67][3]%></td>
  <%}%>
  <%
	 string color_sec_68="";
		if((dt.Rows[68][3].ToString())!="")
		{
			if((dt.Rows[68][3].ToString())=="VD")
			  {
				color_sec_68="color:#806517";
			  }
			 if((dt.Rows[68][3].ToString())=="VC")
			 {
				color_sec_68="color:#3366ff";
			  }
			  if((dt.Rows[68][3].ToString())=="OC")
			  {
				color_sec_68="color:#0BC02C";
			  }
			 if((dt.Rows[68][3].ToString())=="OD")
			 {
				color_sec_68="color:#ff6600";
			  }
			  if((dt.Rows[68][3].ToString())=="OOO")
			  {
				color_sec_68="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_68%>'><%=dt.Rows[68][3]%></td>
  <%}%>
  <%
	 string color_sec_69="";
		if((dt.Rows[69][3].ToString())!="")
		{
			if((dt.Rows[69][3].ToString())=="VD")
			  {
				color_sec_69="color:#806517";
			  }
			 if((dt.Rows[69][3].ToString())=="VC")
			 {
				color_sec_69="color:#3366ff";
			  }
			  if((dt.Rows[69][3].ToString())=="OC")
			  {
				color_sec_69="color:#0BC02C";
			  }
			 if((dt.Rows[69][3].ToString())=="OD")
			 {
				color_sec_69="color:#ff6600";
			  }
			  if((dt.Rows[69][3].ToString())=="OOO")
			  {
				color_sec_69="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_69%>'><%=dt.Rows[69][3]%></td>
  <%}%>
  <%
	 string color_sec_70="";
		if((dt.Rows[70][3].ToString())!="")
		{
			if((dt.Rows[70][3].ToString())=="VD")
			  {
				color_sec_70="color:#806517";
			  }
			 if((dt.Rows[70][3].ToString())=="VC")
			 {
				color_sec_70="color:#3366ff";
			  }
			  if((dt.Rows[70][3].ToString())=="OC")
			  {
				color_sec_70="color:#0BC02C";
			  }
			 if((dt.Rows[70][3].ToString())=="OD")
			 {
				color_sec_70="color:#ff6600";
			  }
			  if((dt.Rows[70][3].ToString())=="OOO")
			  {
				color_sec_70="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_70%>'><%=dt.Rows[70][3]%></td>
  <%}%>
  <%
	 string color_sec_71="";
		if((dt.Rows[71][3].ToString())!="")
		{
			if((dt.Rows[71][3].ToString())=="VD")
			  {
				color_sec_71="color:#806517";
			  }
			 if((dt.Rows[71][3].ToString())=="VC")
			 {
				color_sec_71="color:#3366ff";
			  }
			  if((dt.Rows[71][3].ToString())=="OC")
			  {
				color_sec_71="color:#0BC02C";
			  }
			 if((dt.Rows[71][3].ToString())=="OD")
			 {
				color_sec_71="color:#ff6600";
			  }
			  if((dt.Rows[71][3].ToString())=="OOO")
			  {
				color_sec_71="color:#ff0000";
			  }
          %>
  <td class=xl61 style='border-top:none;border-left:none;<%=color_sec_71%>'><%=dt.Rows[71][3]%></td>
  <%}%>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=12 height=30 class=xl106 style='height:22.5pt'>Block A3</td>
  <td></td>
  <td colspan=12 class=xl107 style='border-right:1.0pt solid black'>Block A10</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt'>101</td>
  <td class=xl26 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl26 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl39 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td class=xl27>101</td>
  <td class=xl27 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl27 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td class=xl39></td>
  <td class=xl40></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl54 style='height:18.0pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td class=xl28 style='border-top:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl55>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_24="";
		if((dt.Rows[24][3].ToString())!="")
		{
			if((dt.Rows[24][3].ToString())=="VD")
			  {
				color_sec_24="color:#806517";
			  }
			 if((dt.Rows[24][3].ToString())=="VC")
			 {
				color_sec_24="color:#3366ff";
			  }
			  if((dt.Rows[24][3].ToString())=="OC")
			  {
				color_sec_24="color:#0BC02C";
			  }
			 if((dt.Rows[24][3].ToString())=="OD")
			 {
				color_sec_24="color:#ff6600";
			  }
			  if((dt.Rows[24][3].ToString())=="OOO")
			  {
				color_sec_24="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_24%>'><%=dt.Rows[24][3]%></td>
  <%}%>
  <%
	 string color_sec_25="";
		if((dt.Rows[25][3].ToString())!="")
		{
			if((dt.Rows[25][3].ToString())=="VD")
			  {
				color_sec_25="color:#806517";
			  }
			 if((dt.Rows[25][3].ToString())=="VC")
			 {
				color_sec_25="color:#3366ff";
			  }
			  if((dt.Rows[25][3].ToString())=="OC")
			  {
				color_sec_25="color:#0BC02C";
			  }
			 if((dt.Rows[25][3].ToString())=="OD")
			 {
				color_sec_25="color:#ff6600";
			  }
			  if((dt.Rows[25][3].ToString())=="OOO")
			  {
				color_sec_25="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_25%>'><%=dt.Rows[25][3]%></td>
  <%}%>
  <%
	 string color_sec_26="";
		if((dt.Rows[26][3].ToString())!="")
		{
			if((dt.Rows[26][3].ToString())=="VD")
			  {
				color_sec_26="color:#806517";
			  }
			 if((dt.Rows[26][3].ToString())=="VC")
			 {
				color_sec_26="color:#3366ff";
			  }
			  if((dt.Rows[26][3].ToString())=="OC")
			  {
				color_sec_26="color:#0BC02C";
			  }
			 if((dt.Rows[26][3].ToString())=="OD")
			 {
				color_sec_26="color:#ff6600";
			  }
			  if((dt.Rows[26][3].ToString())=="OOO")
			  {
				color_sec_26="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_26%>'><%=dt.Rows[26][3]%></td>
  <%}%>
  <%
	 string color_sec_27="";
		if((dt.Rows[27][3].ToString())!="")
		{
			if((dt.Rows[27][3].ToString())=="VD")
			  {
				color_sec_27="color:#806517";
			  }
			 if((dt.Rows[27][3].ToString())=="VC")
			 {
				color_sec_27="color:#3366ff";
			  }
			  if((dt.Rows[27][3].ToString())=="OC")
			  {
				color_sec_27="color:#0BC02C";
			  }
			 if((dt.Rows[27][3].ToString())=="OD")
			 {
				color_sec_27="color:#ff6600";
			  }
			  if((dt.Rows[27][3].ToString())=="OOO")
			  {
				color_sec_27="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_27%>'><%=dt.Rows[27][3]%></td>
  <%}%>
  <%
	 string color_sec_28="";
		if((dt.Rows[28][3].ToString())!="")
		{
			if((dt.Rows[28][3].ToString())=="VD")
			  {
				color_sec_28="color:#806517";
			  }
			 if((dt.Rows[28][3].ToString())=="VC")
			 {
				color_sec_28="color:#3366ff";
			  }
			  if((dt.Rows[28][3].ToString())=="OC")
			  {
				color_sec_28="color:#0BC02C";
			  }
			 if((dt.Rows[28][3].ToString())=="OD")
			 {
				color_sec_28="color:#ff6600";
			  }
			  if((dt.Rows[28][3].ToString())=="OOO")
			  {
				color_sec_28="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_28%>'><%=dt.Rows[28][3]%></td>
  <%}%>
  <%
	 string color_sec_29="";
		if((dt.Rows[29][3].ToString())!="")
		{
			if((dt.Rows[29][3].ToString())=="VD")
			  {
				color_sec_29="color:#806517";
			  }
			 if((dt.Rows[29][3].ToString())=="VC")
			 {
				color_sec_29="color:#3366ff";
			  }
			  if((dt.Rows[29][3].ToString())=="OC")
			  {
				color_sec_29="color:#0BC02C";
			  }
			 if((dt.Rows[29][3].ToString())=="OD")
			 {
				color_sec_29="color:#ff6600";
			  }
			  if((dt.Rows[29][3].ToString())=="OOO")
			  {
				color_sec_29="color:#ff0000";//end block A3
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_29%>'><%=dt.Rows[29][3]%></td>
  <%}%>
  <td colspan=6 class=xl43 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <%
	 string color_sec_72="";
		if((dt.Rows[72][3].ToString())!="")
		{
			if((dt.Rows[72][3].ToString())=="VD")
			  {
				color_sec_72="color:#806517";
			  }
			 if((dt.Rows[72][3].ToString())=="VC")
			 {
				color_sec_72="color:#3366ff";
			  }
			  if((dt.Rows[72][3].ToString())=="OC")
			  {
				color_sec_72="color:#0BC02C";
			  }
			 if((dt.Rows[72][3].ToString())=="OD")
			 {
				color_sec_72="color:#ff6600";
			  }
			  if((dt.Rows[72][3].ToString())=="OOO")
			  {
				color_sec_72="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_72%>'><%=dt.Rows[72][3]%></td>
  <%}%>
  <%
	 string color_sec_73="";
		if((dt.Rows[73][3].ToString())!="")
		{
			if((dt.Rows[73][3].ToString())=="VD")
			  {
				color_sec_73="color:#806517";
			  }
			 if((dt.Rows[73][3].ToString())=="VC")
			 {
				color_sec_73="color:#3366ff";
			  }
			  if((dt.Rows[73][3].ToString())=="OC")
			  {
				color_sec_73="color:#0BC02C";
			  }
			 if((dt.Rows[73][3].ToString())=="OD")
			 {
				color_sec_73="color:#ff6600";
			  }
			  if((dt.Rows[73][3].ToString())=="OOO")
			  {
				color_sec_73="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_73%>'><%=dt.Rows[73][3]%></td>
  <%}%>
  <%
	 string color_sec_74="";
		if((dt.Rows[74][3].ToString())!="")
		{
			if((dt.Rows[74][3].ToString())=="VD")
			  {
				color_sec_74="color:#806517";
			  }
			 if((dt.Rows[74][3].ToString())=="VC")
			 {
				color_sec_74="color:#3366ff";
			  }
			  if((dt.Rows[74][3].ToString())=="OC")
			  {
				color_sec_74="color:#0BC02C";
			  }
			 if((dt.Rows[74][3].ToString())=="OD")
			 {
				color_sec_74="color:#ff6600";
			  }
			  if((dt.Rows[74][3].ToString())=="OOO")
			  {
				color_sec_74="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_74%>'><%=dt.Rows[74][3]%></td>
  <%}%>
  <%
	 string color_sec_75="";
		if((dt.Rows[75][3].ToString())!="")
		{
			if((dt.Rows[75][3].ToString())=="VD")
			  {
				color_sec_75="color:#806517";
			  }
			 if((dt.Rows[75][3].ToString())=="VC")
			 {
				color_sec_75="color:#3366ff";
			  }
			  if((dt.Rows[75][3].ToString())=="OC")
			  {
				color_sec_75="color:#0BC02C";
			  }
			 if((dt.Rows[75][3].ToString())=="OD")
			 {
				color_sec_75="color:#ff6600";
			  }
			  if((dt.Rows[75][3].ToString())=="OOO")
			  {
				color_sec_75="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_75%>'><%=dt.Rows[75][3]%></td>
  <%}%>
  <%
	 string color_sec_76="";
		if((dt.Rows[76][3].ToString())!="")
		{
			if((dt.Rows[76][3].ToString())=="VD")
			  {
				color_sec_76="color:#806517";
			  }
			 if((dt.Rows[76][3].ToString())=="VC")
			 {
				color_sec_76="color:#3366ff";
			  }
			  if((dt.Rows[76][3].ToString())=="OC")
			  {
				color_sec_76="color:#0BC02C";
			  }
			 if((dt.Rows[76][3].ToString())=="OD")
			 {
				color_sec_76="color:#ff6600";
			  }
			  if((dt.Rows[76][3].ToString())=="OOO")
			  {
				color_sec_76="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_76%>'><%=dt.Rows[76][3]%></td>
  <%}%>
  <%
	 string color_sec_77="";
		if((dt.Rows[77][3].ToString())!="")
		{
			if((dt.Rows[77][3].ToString())=="VD")
			  {
				color_sec_77="color:#806517";
			  }
			 if((dt.Rows[77][3].ToString())=="VC")
			 {
				color_sec_77="color:#3366ff";
			  }
			  if((dt.Rows[77][3].ToString())=="OC")
			  {
				color_sec_77="color:#0BC02C";
			  }
			 if((dt.Rows[77][3].ToString())=="OD")
			 {
				color_sec_77="color:#ff6600";
			  }
			  if((dt.Rows[77][3].ToString())=="OOO")
			  {
				color_sec_77="color:#ff0000";//end block A10
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;width:35pt;<%=color_sec_77%>'><%=dt.Rows[77][3]%></td>
  <%}%>
  <td class=xl44 style='mso-ignore:colspan;border-bottom:.5pt solid windowtext'></td>
  <td class=xl45 style='mso-ignore:colspan;border-bottom:.5pt solid windowtext'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan;border-bottom:.5pt solid windowtext'></td>
  <td class=xl57 style='mso-ignore:colspan;border-bottom:.5pt solid windowtext'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=12 height=29 class=xl106 style='height:21.75pt'>Block A4</td>
  <td colspan=12 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt'>101</td>
  <td class=xl26 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl26 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40 ></td>
  <td class=xl39 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td class=xl63 colspan=4 style='mso-ignore:colspan'>To: General Manager</td>
  <td colspan=3 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td class=xl65></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl54 style='height:17.25pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_30="";
		if((dt.Rows[30][3].ToString())!="")
		{
			if((dt.Rows[30][3].ToString())=="VD")
			  {
				color_sec_30="color:#806517";
			  }
			 if((dt.Rows[30][3].ToString())=="VC")
			 {
				color_sec_30="color:#3366ff";
			  }
			  if((dt.Rows[30][3].ToString())=="OC")
			  {
				color_sec_30="color:#0BC02C";
			  }
			 if((dt.Rows[30][3].ToString())=="OD")
			 {
				color_sec_30="color:#ff6600";
			  }
			  if((dt.Rows[30][3].ToString())=="OOO")
			  {
				color_sec_30="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_30%>'><%=dt.Rows[30][3]%></td>
  <%}%>
  <%
	 string color_sec_31="";
		if((dt.Rows[31][3].ToString())!="")
		{
			if((dt.Rows[31][3].ToString())=="VD")
			  {
				color_sec_31="color:#806517";
			  }
			 if((dt.Rows[31][3].ToString())=="VC")
			 {
				color_sec_31="color:#3366ff";
			  }
			  if((dt.Rows[31][3].ToString())=="OC")
			  {
				color_sec_31="color:#0BC02C";
			  }
			 if((dt.Rows[31][3].ToString())=="OD")
			 {
				color_sec_31="color:#ff6600";
			  }
			  if((dt.Rows[31][3].ToString())=="OOO")
			  {
				color_sec_31="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_31%>'><%=dt.Rows[31][3]%></td>
  <%}%>
  <%
	 string color_sec_32="";
		if((dt.Rows[32][3].ToString())!="")
		{
			if((dt.Rows[32][3].ToString())=="VD")
			  {
				color_sec_32="color:#806517";
			  }
			 if((dt.Rows[32][3].ToString())=="VC")
			 {
				color_sec_32="color:#3366ff";
			  }
			  if((dt.Rows[32][3].ToString())=="OC")
			  {
				color_sec_32="color:#0BC02C";
			  }
			 if((dt.Rows[32][3].ToString())=="OD")
			 {
				color_sec_32="color:#ff6600";
			  }
			  if((dt.Rows[32][3].ToString())=="OOO")
			  {
				color_sec_32="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_32%>'><%=dt.Rows[32][3]%></td>
  <%}%>
  <%
	 string color_sec_33="";
		if((dt.Rows[33][3].ToString())!="")
		{
			if((dt.Rows[33][3].ToString())=="VD")
			  {
				color_sec_33="color:#806517";
			  }
			 if((dt.Rows[33][3].ToString())=="VC")
			 {
				color_sec_33="color:#3366ff";
			  }
			  if((dt.Rows[33][3].ToString())=="OC")
			  {
				color_sec_33="color:#0BC02C";
			  }
			 if((dt.Rows[33][3].ToString())=="OD")
			 {
				color_sec_33="color:#ff6600";
			  }
			  if((dt.Rows[33][3].ToString())=="OOO")
			  {
				color_sec_33="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_33%>'><%=dt.Rows[33][3]%></td>
  <%}%>
  <%
	 string color_sec_34="";
		if((dt.Rows[34][3].ToString())!="")
		{
			if((dt.Rows[34][3].ToString())=="VD")
			  {
				color_sec_34="color:#806517";
			  }
			 if((dt.Rows[34][3].ToString())=="VC")
			 {
				color_sec_34="color:#3366ff";
			  }
			  if((dt.Rows[34][3].ToString())=="OC")
			  {
				color_sec_34="color:#0BC02C";
			  }
			 if((dt.Rows[34][3].ToString())=="OD")
			 {
				color_sec_34="color:#ff6600";
			  }
			  if((dt.Rows[34][3].ToString())=="OOO")
			  {
				color_sec_34="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_34%>'><%=dt.Rows[34][3]%></td>
  <%}%>
  <%
	 string color_sec_35="";
		if((dt.Rows[35][3].ToString())!="")
		{
			if((dt.Rows[35][3].ToString())=="VD")
			  {
				color_sec_35="color:#806517";
			  }
			 if((dt.Rows[35][3].ToString())=="VC")
			 {
				color_sec_35="color:#3366ff";
			  }
			  if((dt.Rows[35][3].ToString())=="OC")
			  {
				color_sec_35="color:#0BC02C";
			  }
			 if((dt.Rows[35][3].ToString())=="OD")
			 {
				color_sec_35="color:#ff6600";
			  }
			  if((dt.Rows[35][3].ToString())=="OOO")
			  {
				color_sec_35="color:#ff0000";//end block A4
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_35%>'><%=dt.Rows[35][3]%></td>
  <%}%>
  <td colspan=6 class=xl43 style='mso-ignore:colspan;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=8 class=xl86 x:str>Village A080
  SQM(A080):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl34 align=right style='border-left:none' x:num><%=dt2.Rows[0][0]%></td>
  <td colspan=3 class=xl92 style='border-right:1.0pt solid black;border-left:
  none'>( 80m2)</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=12 height=30 class=xl82 style='height:22.5pt'>Block A5</td>
  <td></td>
  <td colspan=8 class=xl91 x:str>Village A110
  SQM(A110):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[0][1]%></td>
  <td colspan=3 class=xl92 style='border-right:1.0pt solid black;border-left:
  none'>(110m2)</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt'>101</td>
  <td class=xl26 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl26 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan;border-top:.5pt solid windowtext'></td>
  <td class=xl40 style='mso-ignore:colspan;border-top:.5pt solid windowtext'></td>
  <td class=xl39 style='mso-ignore:colspan;border-top:.5pt solid windowtext;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=8 class=xl113 style='border-right:.5pt solid black'>Total:</td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[0][2]%></td>
  <td colspan=3 class=xl92 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl54 style='height:18.0pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan;;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=12 class=xl92 style='border-right:1.0pt solid black'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_36="";
		if((dt.Rows[36][3].ToString())!="")
		{
			if((dt.Rows[36][3].ToString())=="VD")
			  {
				color_sec_36="color:#806517";
			  }
			 if((dt.Rows[36][3].ToString())=="VC")
			 {
				color_sec_36="color:#3366ff";
			  }
			  if((dt.Rows[36][3].ToString())=="OC")
			  {
				color_sec_36="color:#0BC02C";
			  }
			 if((dt.Rows[36][3].ToString())=="OD")
			 {
				color_sec_36="color:#ff6600";
			  }
			  if((dt.Rows[36][3].ToString())=="OOO")
			  {
				color_sec_36="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_36%>'><%=dt.Rows[36][3]%></td>
  <%}%>
  <%
	 string color_sec_37="";
		if((dt.Rows[37][3].ToString())!="")
		{
			if((dt.Rows[37][3].ToString())=="VD")
			  {
				color_sec_37="color:#806517";
			  }
			 if((dt.Rows[37][3].ToString())=="VC")
			 {
				color_sec_37="color:#3366ff";
			  }
			  if((dt.Rows[37][3].ToString())=="OC")
			  {
				color_sec_37="color:#0BC02C";
			  }
			 if((dt.Rows[37][3].ToString())=="OD")
			 {
				color_sec_37="color:#ff6600";
			  }
			  if((dt.Rows[37][3].ToString())=="OOO")
			  {
				color_sec_37="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_37%>'><%=dt.Rows[37][3]%></td>
  <%}%>
  <%
	 string color_sec_38="";
		if((dt.Rows[38][3].ToString())!="")
		{
			if((dt.Rows[38][3].ToString())=="VD")
			  {
				color_sec_38="color:#806517";
			  }
			 if((dt.Rows[38][3].ToString())=="VC")
			 {
				color_sec_38="color:#3366ff";
			  }
			  if((dt.Rows[38][3].ToString())=="OC")
			  {
				color_sec_38="color:#0BC02C";
			  }
			 if((dt.Rows[38][3].ToString())=="OD")
			 {
				color_sec_38="color:#ff6600";
			  }
			  if((dt.Rows[38][3].ToString())=="OOO")
			  {
				color_sec_38="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_38%>'><%=dt.Rows[38][3]%></td>
  <%}%>
  <%
	 string color_sec_39="";
		if((dt.Rows[39][3].ToString())!="")
		{
			if((dt.Rows[39][3].ToString())=="VD")
			  {
				color_sec_39="color:#806517";
			  }
			 if((dt.Rows[39][3].ToString())=="VC")
			 {
				color_sec_39="color:#3366ff";
			  }
			  if((dt.Rows[39][3].ToString())=="OC")
			  {
				color_sec_39="color:#0BC02C";
			  }
			 if((dt.Rows[39][3].ToString())=="OD")
			 {
				color_sec_39="color:#ff6600";
			  }
			  if((dt.Rows[39][3].ToString())=="OOO")
			  {
				color_sec_39="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_39%>'><%=dt.Rows[39][3]%></td>
  <%}%>
  <%
	 string color_sec_40="";
		if((dt.Rows[40][3].ToString())!="")
		{
			if((dt.Rows[40][3].ToString())=="VD")
			  {
				color_sec_40="color:#806517";
			  }
			 if((dt.Rows[40][3].ToString())=="VC")
			 {
				color_sec_40="color:#3366ff";
			  }
			  if((dt.Rows[40][3].ToString())=="OC")
			  {
				color_sec_40="color:#0BC02C";
			  }
			 if((dt.Rows[40][3].ToString())=="OD")
			 {
				color_sec_40="color:#ff6600";
			  }
			  if((dt.Rows[40][3].ToString())=="OOO")
			  {
				color_sec_40="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_40%>'><%=dt.Rows[40][3]%></td>
  <%}%>
  <%
	 string color_sec_41="";
		if((dt.Rows[41][3].ToString())!="")
		{
			if((dt.Rows[41][3].ToString())=="VD")
			  {
				color_sec_41="color:#806517";
			  }
			 if((dt.Rows[41][3].ToString())=="VC")
			 {
				color_sec_41="color:#3366ff";
			  }
			  if((dt.Rows[41][3].ToString())=="OC")
			  {
				color_sec_41="color:#0BC02C";
			  }
			 if((dt.Rows[41][3].ToString())=="OD")
			 {
				color_sec_41="color:#ff6600";
			  }
			  if((dt.Rows[41][3].ToString())=="OOO")
			  {
				color_sec_41="color:#ff0000";//end block A5
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_41%>'><%=dt.Rows[41][3]%></td>
  <%}%>
  <td colspan=6 class=xl43 style='mso-ignore:colspan;;border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=7 class=xl89>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>A080</td>
  <td class=xl37 style='border-top:none;border-left:none'>A110</td>
  <td colspan=3 class=xl92 style='border-right:1.0pt solid black;border-left:
  none'>Total</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=12 height=33 class=xl77 style='height:24.75pt'>Block A6</td>
  <td></td>
  <td colspan=7 class=xl35>O.O.O</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][0]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[1][1]%></td>
  <td colspan=3 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[1][2]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt'>101</td>
  <td class=xl26 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl26 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td class=xl39 style='border-top:.5pt solid windowtext'></td> 
  <td class=xl40 style='border-top:.5pt solid windowtext'></td> 
  <td class=xl39 style='border-top:.5pt solid windowtext'></td> 
  <td class=xl40 style='border-top:.5pt solid windowtext'></td> 
  <td class=xl39 style='border-top:.5pt solid windowtext'></td> 
  <td class=xl40 style='border-top:.5pt solid windowtext;border-right:.5pt solid windowtext'></td> 
  <td></td>
  <td colspan=7 class=xl85>O.C</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][0]%></td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[2][1]%></td>
  <td colspan=3 class=xl98 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[2][2]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl54 style='height:18.0pt;border-top:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td class=xl28 style='border-top:none;border-left:none'>A110</td>
  <td class=xl50 style='border-top:none;border-left:none'>A110</td>
  <td colspan=6 class=xl41 style='border-right:.5pt solid windowtext'></td> 
  <td></td>
  <td colspan=7 class=xl86>O.D</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][0]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[3][1]%></td>
  <td colspan=3 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[3][2]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_42="";
		if((dt.Rows[42][3].ToString())!="")
		{
			if((dt.Rows[42][3].ToString())=="VD")
			  {
				color_sec_42="color:#806517";
			  }
			 if((dt.Rows[42][3].ToString())=="VC")
			 {
				color_sec_42="color:#3366ff";
			  }
			  if((dt.Rows[42][3].ToString())=="OC")
			  {
				color_sec_42="color:#0BC02C";
			  }
			 if((dt.Rows[42][3].ToString())=="OD")
			 {
				color_sec_42="color:#ff6600";
			  }
			  if((dt.Rows[42][3].ToString())=="OOO")
			  {
				color_sec_42="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_42%>'><%=dt.Rows[42][3]%></td>
  <%}%>
  <%
	 string color_sec_43="";
		if((dt.Rows[43][3].ToString())!="")
		{
			if((dt.Rows[43][3].ToString())=="VD")
			  {
				color_sec_43="color:#806517";
			  }
			 if((dt.Rows[43][3].ToString())=="VC")
			 {
				color_sec_43="color:#3366ff";
			  }
			  if((dt.Rows[43][3].ToString())=="OC")
			  {
				color_sec_43="color:#0BC02C";
			  }
			 if((dt.Rows[43][3].ToString())=="OD")
			 {
				color_sec_43="color:#ff6600";
			  }
			  if((dt.Rows[43][3].ToString())=="OOO")
			  {
				color_sec_43="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_43%>'><%=dt.Rows[43][3]%></td>
  <%}%>
  <%
	 string color_sec_44="";
		if((dt.Rows[44][3].ToString())!="")
		{
			if((dt.Rows[44][3].ToString())=="VD")
			  {
				color_sec_44="color:#806517";
			  }
			 if((dt.Rows[44][3].ToString())=="VC")
			 {
				color_sec_44="color:#3366ff";
			  }
			  if((dt.Rows[44][3].ToString())=="OC")
			  {
				color_sec_44="color:#0BC02C";
			  }
			 if((dt.Rows[44][3].ToString())=="OD")
			 {
				color_sec_44="color:#ff6600";
			  }
			  if((dt.Rows[44][3].ToString())=="OOO")
			  {
				color_sec_44="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_44%>'><%=dt.Rows[44][3]%></td>
  <%}%>
  <%
	 string color_sec_45="";
		if((dt.Rows[45][3].ToString())!="")
		{
			if((dt.Rows[45][3].ToString())=="VD")
			  {
				color_sec_45="color:#806517";
			  }
			 if((dt.Rows[45][3].ToString())=="VC")
			 {
				color_sec_45="color:#3366ff";
			  }
			  if((dt.Rows[45][3].ToString())=="OC")
			  {
				color_sec_45="color:#0BC02C";
			  }
			 if((dt.Rows[45][3].ToString())=="OD")
			 {
				color_sec_45="color:#ff6600";
			  }
			  if((dt.Rows[45][3].ToString())=="OOO")
			  {
				color_sec_45="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_45%>'><%=dt.Rows[45][3]%></td>
  <%}%>
  <%
	 string color_sec_46="";
		if((dt.Rows[46][3].ToString())!="")
		{
			if((dt.Rows[46][3].ToString())=="VD")
			  {
				color_sec_46="color:#806517";
			  }
			 if((dt.Rows[46][3].ToString())=="VC")
			 {
				color_sec_46="color:#3366ff";
			  }
			  if((dt.Rows[46][3].ToString())=="OC")
			  {
				color_sec_46="color:#0BC02C";
			  }
			 if((dt.Rows[46][3].ToString())=="OD")
			 {
				color_sec_46="color:#ff6600";
			  }
			  if((dt.Rows[46][3].ToString())=="OOO")
			  {
				color_sec_46="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_46%>'><%=dt.Rows[46][3]%></td>
  <%}%>
  <%
	 string color_sec_47="";
		if((dt.Rows[47][3].ToString())!="")
		{
			if((dt.Rows[47][3].ToString())=="VD")
			  {
				color_sec_47="color:#806517";
			  }
			 if((dt.Rows[47][3].ToString())=="VC")
			 {
				color_sec_47="color:#3366ff";
			  }
			  if((dt.Rows[47][3].ToString())=="OC")
			  {
				color_sec_47="color:#0BC02C";
			  }
			 if((dt.Rows[47][3].ToString())=="OD")
			 {
				color_sec_47="color:#ff6600";
			  }
			  if((dt.Rows[47][3].ToString())=="OOO")
			  {
				color_sec_47="color:#ff0000";//end block A6
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_47%>'><%=dt.Rows[47][3]%></td>
  <%}%>
  <td colspan=3 class=xl44 style='border-bottom:.5pt solid windowtext;'></td> 
  <td class=xl45 style='border-bottom:.5pt solid windowtext;'></td> 
  <td colspan=2 class=xl43 style='border-bottom:.5pt solid windowtext;border-right:.5pt solid windowtext'></td> 
  <td></td>
  <td colspan=7 class=xl87>V.C</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][0]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[4][1]%></td>
  <td colspan=3 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[4][2]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=12 height=32 class=xl80 style='height:24.0pt'>Block A7</td>
  <td></td>
  <td colspan=7 class=xl88>V.D</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][0]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[5][1]%></td>
  <td colspan=3 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[5][2]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl58 style='height:18.0pt'>101</td>
  <td class=xl26 style='border-left:none'>102</td>
  <td class=xl27 style='border-left:none'>201</td>
  <td class=xl26 style='border-left:none'>202</td>
  <td class=xl27 style='border-left:none'>301</td>
  <td class=xl26 style='border-left:none'>302</td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl39 style='border-right:.5pt solid windowtext'></td>
  <td></td>
  <td colspan=7 class=xl94>H.U</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][2]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[6][1]%></td>
  <td colspan=3 class=xl96 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[6][2]%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl54 style='height:18.75pt;border-top:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td class=xl28 style='border-top:none;border-left:none'>A080</td>
  <td class=xl50 style='border-top:none;border-left:none'>A080</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid windowtext'></td> 
  <td></td>
  <td colspan=7 class=xl95>Occupied %</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][2]%></td>
  <td class=xl47 align=right style='border-top:none;border-left:none' x:num><%=dt2.Rows[7][2]%></td>
  <td colspan=3 class=xl100 style='border-right:1.0pt solid black;border-left:
  none' x:num><%=dt2.Rows[7][2]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 <%
	 string color_sec_48="";
		if((dt.Rows[48][3].ToString())!="")
		{
			if((dt.Rows[48][3].ToString())=="VD")
			  {
				color_sec_48="color:#806517";
			  }
			 if((dt.Rows[48][3].ToString())=="VC")
			 {
				color_sec_48="color:#3366ff";
			  }
			  if((dt.Rows[48][3].ToString())=="OC")
			  {
				color_sec_48="color:#0BC02C";
			  }
			 if((dt.Rows[48][3].ToString())=="OD")
			 {
				color_sec_48="color:#ff6600";
			  }
			  if((dt.Rows[48][3].ToString())=="OOO")
			  {
				color_sec_48="color:#ff0000";
			  }
          %>
  <td height=24 class=xl56 width=46 style='height:18.0pt;border-top:none;
  width:35pt;<%=color_sec_48%>'><%=dt.Rows[48][3]%></td>
  <%}%>
  <%
	 string color_sec_49="";
		if((dt.Rows[49][3].ToString())!="")
		{
			if((dt.Rows[49][3].ToString())=="VD")
			  {
				color_sec_49="color:#806517";
			  }
			 if((dt.Rows[49][3].ToString())=="VC")
			 {
				color_sec_49="color:#3366ff";
			  }
			  if((dt.Rows[49][3].ToString())=="OC")
			  {
				color_sec_49="color:#0BC02C";
			  }
			 if((dt.Rows[49][3].ToString())=="OD")
			 {
				color_sec_49="color:#ff6600";
			  }
			  if((dt.Rows[49][3].ToString())=="OOO")
			  {
				color_sec_49="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_49%>'><%=dt.Rows[49][3]%></td>
  <%}%>
  <%
	 string color_sec_50="";
		if((dt.Rows[50][3].ToString())!="")
		{
			if((dt.Rows[50][3].ToString())=="VD")
			  {
				color_sec_50="color:#806517";
			  }
			 if((dt.Rows[50][3].ToString())=="VC")
			 {
				color_sec_50="color:#3366ff";
			  }
			  if((dt.Rows[50][3].ToString())=="OC")
			  {
				color_sec_50="color:#0BC02C";
			  }
			 if((dt.Rows[50][3].ToString())=="OD")
			 {
				color_sec_50="color:#ff6600";
			  }
			  if((dt.Rows[50][3].ToString())=="OOO")
			  {
				color_sec_50="color:#ff0000";
			  }
          %>
  <td class=xl31 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_50%>'><%=dt.Rows[50][3]%></td>
  <%}%>
  <%
	 string color_sec_51="";
		if((dt.Rows[51][3].ToString())!="")
		{
			if((dt.Rows[51][3].ToString())=="VD")
			  {
				color_sec_51="color:#806517";
			  }
			 if((dt.Rows[51][3].ToString())=="VC")
			 {
				color_sec_51="color:#3366ff";
			  }
			  if((dt.Rows[51][3].ToString())=="OC")
			  {
				color_sec_51="color:#0BC02C";
			  }
			 if((dt.Rows[51][3].ToString())=="OD")
			 {
				color_sec_51="color:#ff6600";
			  }
			  if((dt.Rows[51][3].ToString())=="OOO")
			  {
				color_sec_51="color:#ff0000";
			  }
          %>
  <td class=xl32 width=46 style='border-top:none;border-left:none;width:35pt;<%=color_sec_51%>'><%=dt.Rows[51][3]%></td>
  <%}%>
  <%
	 string color_sec_52="";
		if((dt.Rows[52][3].ToString())!="")
		{
			if((dt.Rows[52][3].ToString())=="VD")
			  {
				color_sec_52="color:#806517";
			  }
			 if((dt.Rows[52][3].ToString())=="VC")
			 {
				color_sec_52="color:#3366ff";
			  }
			  if((dt.Rows[52][3].ToString())=="OC")
			  {
				color_sec_52="color:#0BC02C";
			  }
			 if((dt.Rows[52][3].ToString())=="OD")
			 {
				color_sec_52="color:#ff6600";
			  }
			  if((dt.Rows[52][3].ToString())=="OOO")
			  {
				color_sec_52="color:#ff0000";
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_52%>'><%=dt.Rows[52][3]%></td>
  <%}%>
  <%
	 string color_sec_53="";
		if((dt.Rows[53][3].ToString())!="")
		{
			if((dt.Rows[53][3].ToString())=="VD")
			  {
				color_sec_53="color:#806517";
			  }
			 if((dt.Rows[53][3].ToString())=="VC")
			 {
				color_sec_53="color:#3366ff";
			  }
			  if((dt.Rows[53][3].ToString())=="OC")
			  {
				color_sec_53="color:#0BC02C";
			  }
			 if((dt.Rows[53][3].ToString())=="OD")
			 {
				color_sec_53="color:#ff6600";
			  }
			  if((dt.Rows[53][3].ToString())=="OOO")
			  {
				color_sec_53="color:#ff0000";//end block A7
			  }
          %>
  <td class=xl33 style='border-top:none;border-left:none;<%=color_sec_53%>'><%=dt.Rows[53][3]%></td>
  <%}%>
  <td colspan=6 class=xl43 style='border-bottom:.5pt solid windowtext;border-right:.5pt solid windowtext'></td> 
  <td></td>
  <td colspan=11 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td></td>
  <td colspan=7 class=xl116 x:str="Checked by : ">Checked by :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt'>&nbsp;</td>
  <td colspan=23 style='mso-ignore:colspan'></td>
  <td class=xl62>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl73 style='height:13.5pt'>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
