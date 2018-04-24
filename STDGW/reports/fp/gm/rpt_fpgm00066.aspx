<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string day = Request.QueryString["day"];
    string year = day.Substring(0, 4);
    string month = "";
    
    if(day.Substring(4, 2) == "01")
    {
        month = "January";
    }
    if (day.Substring(4, 2) == "02")
    {
        month = "February";
    }
    if (day.Substring(4, 2) == "03")
    {
        month = "March";
    }
    if (day.Substring(4, 2) == "04")
    {
        month = "April";
    }
    if (day.Substring(4, 2) == "05")
    {
        month = "May";
    }
    if (day.Substring(4, 2) == "06")
    {
        month = "June";
    }
    if (day.Substring(4, 2) == "07")
    {
        month = "July";
    }
    if (day.Substring(4, 2) == "08")
    {
        month = "August";
    }
    if (day.Substring(4, 2) == "09")
    {
        month = "Septemper";
    }
    if (day.Substring(4, 2) == "10")
    {
        month = "October";
    }
    if (day.Substring(4, 2) == "11")
    {
        month = "November";
    }
    if (day.Substring(4, 2) == "12")
    {
        month = "December";
    }
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpgm00066", "'" + day + "'");
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="August'09_files/filelist.xml">
<link rel=Edit-Time-Data href="August'09_files/editdata.mso">
<link rel=OLE-Object-Data href="August'09_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>.</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2008-06-17T06:17:10Z</o:LastPrinted>
  <o:Created>2007-06-18T07:23:43Z</o:Created>
  <o:LastSaved>2009-12-26T07:59:21Z</o:LastSaved>
  <o:Company>.</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.style0
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
	font-family:\B3CB\C6C0;
	mso-generic-font-family:auto;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0;
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	text-align:center;
	border:.5pt dotted windowtext;
	background:white;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:white;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt dotted windowtext;}
.xl51
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt dotted windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;}
.xl55
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	text-align:center;
	border:.5pt dotted windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt dotted windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt dotted windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt dotted windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl65
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dashed windowtext;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:"Courier New", monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>tl production</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>3090</x:WindowHeight>
  <x:WindowWidth>15330</x:WindowWidth>
  <x:WindowTopX>-15</x:WindowTopX>
  <x:WindowTopY>6075</x:WindowTopY>
  <x:TabRatio>652</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path> </x:Path>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:SheetName> </x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>10</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>11</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>12</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>13</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>14</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>15</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>16</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>17</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>18</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>19</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>20</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>21</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>22</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>23</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>24</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>25</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>26</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>27</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="679937"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=5713 style='border-collapse:
 collapse;table-layout:fixed;width:4292pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:3968;
 width:93pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:2880;
 width:68pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3328;
 width:78pt'>
 <col class=xl24 width=156 style='mso-width-source:userset;mso-width-alt:4992;
 width:117pt'>
 <col class=xl24 width=86 span=2 style='mso-width-source:userset;mso-width-alt:
 2752;width:65pt'>
 <col class=xl33 width=86 span=29 style='mso-width-source:userset;mso-width-alt:
 2752;width:65pt'>
 <col class=xl24 width=159 style='mso-width-source:userset;mso-width-alt:5088;
 width:119pt'>
 <col class=xl24 width=71 span=220 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <tr class=xl27 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=32 height=33 class=xl81 width=2882 style='height:24.95pt;
  width:2176pt'>S&amp;J HOSIERY(VIETNAM) Co.,LTD</td>
  <td class=xl77 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl77 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl77 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl28 width=159 style='width:119pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
  <td class=xl27 width=71 style='width:53pt'></td>
 </tr>
 <tr class=xl32 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=32 height=20 class=xl78 style='height:15.0pt'>TOTAL PRODUCTION
  (<%=month %> <%=year%>)</td>
  <td colspan=3 class=xl78 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td colspan=31 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=6 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl26 style='height:26.25pt'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-left:none'>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td colspan=34 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl35 style='height:26.25pt'>SECTION</td>
  <td class=xl36 style='border-left:none'>M/C Q'TY</td>
  <td class=xl37 style='border-left:none'>TARGET Q'TY</td>
  <td class=xl65 width=156 style='width:117pt'>TOTAL PRODUCTION</td>
  <td class=xl38 style='border-top:none' >Day 1</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 2</td>
  <td class=xl38 style='border-top:none' >Day 3</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 4</td>
  <td class=xl38 style='border-top:none' >Day 5</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 6</td>
  <td class=xl38 style='border-top:none' >Day 7</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 8</td>
  <td class=xl38 style='border-top:none' >Day 9</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 10</td>
  <td class=xl38 style='border-top:none' >Day 11</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 12</td>
  <td class=xl38 style='border-top:none' >Day 13</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 14</td>
  <td class=xl38 style='border-top:none'>Day 15</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 16</td>
  <td class=xl38 style='border-top:none' >Day 17</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 18</td>
  <td class=xl38 style='border-top:none' >Day 19</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 20</td>
  <td class=xl38 style='border-top:none' >Day 21</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 22</td>
  <td class=xl38 style='border-top:none' >Day 23</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 24</td>
  <td class=xl38 style='border-top:none'>Day 25</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 26</td>
  <td class=xl38 style='border-top:none' >Day 27</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 28</td>
  <td class=xl38 style='border-top:none'>Day 29</td>
  <td class=xl39 style='border-top:none;border-left:none' >Day 30</td>
  <td class=xl38 style='border-top:none' >Day 31</td>
  <td class=xl40 style='border-top:none;border-left:none'>REMARKS</td>
  <td colspan=34 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
         double tot1 = 0, tot2 = 0, tot3 = 0, tot4 = 0, tot5 = 0, tot6 = 0, tot7 = 0, tot8 = 0, tot9 = 0, tot10 = 0, tot11 = 0;
         double tot12 = 0, tot13 = 0, tot14 = 0, tot15 = 0, tot16 = 0, tot17 = 0, tot18 = 0, tot19 = 0, tot20 = 0, tot21 = 0, tot22 = 0;
         double tot23 = 0, tot24 = 0, tot25 = 0, tot26 = 0, tot27 = 0, tot28 = 0, tot29 = 0, tot30 = 0, tot31 = 0;
         double tot_production = 0;
         for (int i = 0; i < dt.Rows.Count; i++)
         {
             tot1 = tot1 + CommondLib.ConvertToDbl(dt.Rows[i][4]);

             tot2 = tot2 + CommondLib.ConvertToDbl(dt.Rows[i][5]);
             tot3 = tot3 + CommondLib.ConvertToDbl(dt.Rows[i][6]);
             tot4 = tot4 + CommondLib.ConvertToDbl(dt.Rows[i][7]);
             tot5 = tot5 + CommondLib.ConvertToDbl(dt.Rows[i][8]);
             tot6 = tot6 + CommondLib.ConvertToDbl(dt.Rows[i][9]);
             tot7 = tot7 + CommondLib.ConvertToDbl(dt.Rows[i][10]);
             tot8 = tot8 + CommondLib.ConvertToDbl(dt.Rows[i][11]);
             tot9 = tot9 + CommondLib.ConvertToDbl(dt.Rows[i][12]);
             tot10 = tot10 + CommondLib.ConvertToDbl(dt.Rows[i][13]);
             tot11 = tot11 + CommondLib.ConvertToDbl(dt.Rows[i][14]);
             tot12 = tot12 + CommondLib.ConvertToDbl(dt.Rows[i][15]);
             tot13 = tot13 + CommondLib.ConvertToDbl(dt.Rows[i][16]);
             tot14 = tot14 + CommondLib.ConvertToDbl(dt.Rows[i][17]);
             tot15 = tot15 + CommondLib.ConvertToDbl(dt.Rows[i][18]);
             tot16 = tot16 + CommondLib.ConvertToDbl(dt.Rows[i][19]);
             tot17 = tot17 + CommondLib.ConvertToDbl(dt.Rows[i][20]);
             tot18 = tot18 + CommondLib.ConvertToDbl(dt.Rows[i][21]);
             tot19 = tot19 + CommondLib.ConvertToDbl(dt.Rows[i][22]);
             tot20 = tot20 + CommondLib.ConvertToDbl(dt.Rows[i][23]);
             tot21 = tot21 + CommondLib.ConvertToDbl(dt.Rows[i][24]);
             tot22 = tot22 + CommondLib.ConvertToDbl(dt.Rows[i][25]);
             tot23 = tot23 + CommondLib.ConvertToDbl(dt.Rows[i][26]);
             tot24 = tot24 + CommondLib.ConvertToDbl(dt.Rows[i][27]);
             tot25 = tot25 + CommondLib.ConvertToDbl(dt.Rows[i][28]);
             tot26 = tot26 + CommondLib.ConvertToDbl(dt.Rows[i][29]);
             tot27 = tot27 + CommondLib.ConvertToDbl(dt.Rows[i][30]);
             tot28 = tot28 + CommondLib.ConvertToDbl(dt.Rows[i][31]);
             tot29 = tot29 + CommondLib.ConvertToDbl(dt.Rows[i][32]);
             tot30 = tot30 + CommondLib.ConvertToDbl(dt.Rows[i][33]);
             tot31 = tot31 + CommondLib.ConvertToDbl(dt.Rows[i][34]);
             tot_production = tot_production + CommondLib.ConvertToDbl(dt.Rows[i][3]);
        
        %>
        

 <tr class=xl47 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl41 style='height:20.1pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl42 style='border-top:none;border-left:none' ><%=dt.Rows[i][1]%></td>
  <td class=xl43 style='border-top:none;border-left:none' ><%=dt.Rows[i][2]%></td>
  <td class=xl44 align=center style='border-top:none'><%=dt.Rows[i][3]%></td>
  <td class=xl45 align=center style='border-top:none'><%=dt.Rows[i][4]%></td>
  <td class=xl45 style='border-top:none' ><%=dt.Rows[i][5]%></td>
  <td class=xl45 align=center style='border-top:none'><%=dt.Rows[i][6]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][7]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][8]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][9]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][10]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][11]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][12]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][13]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][14]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][15]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][16]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][17]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][18]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][19]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][20]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][21]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][22]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][23]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][24]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][25]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][26]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][27]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][28]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][29]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][30]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][31]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][32]%></td>
  <td class=xl45 style='border-top:none'><%=dt.Rows[i][33]%></td>
  <td class=xl80 style='border-top:none'><%=dt.Rows[i][34]%></td>
  <td class=xl46 style='border-top:none'></td>
  <td colspan=34 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
         <%
     }
  %>
 
 <tr class=xl54 height=22 style='height:16.5pt'>
  <td height=22 class=xl56 style='height:16.5pt;border-top:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none'>&nbsp;</td>
  <td colspan=34 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl47 height=60 style='mso-height-source:userset;height:45.0pt'>
  <td height=60 class=xl59 style='height:45.0pt;border-top:none'>TOTAL:</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 align=center style='border-top:none' ><%=tot_production%></td>
  <td class=xl62 align=center style='border-top:none' ><%=tot1%></td>
  <td class=xl62 style='border-top:none'><%=tot2%></td>
  <td class=xl62 align=center style='border-top:none' ><%=tot3%></td>
  <td class=xl62 style='border-top:none'><%=tot4%></td>
  <td class=xl62 style='border-top:none'><%=tot5%></td>
  <td class=xl62 style='border-top:none'><%=tot6%></td>
  <td class=xl62 style='border-top:none'><%=tot7%></td>
  <td class=xl62 style='border-top:none' ><%=tot8%></td>
  <td class=xl62 style='border-top:none'><%=tot9%></td>
  <td class=xl62 style='border-top:none' ><%=tot10%></td>
  <td class=xl62 style='border-top:none' ><%=tot11%></td>
  <td class=xl62 style='border-top:none' ><%=tot12%></td>
  <td class=xl62 style='border-top:none' ><%=tot13%></td>
  <td class=xl62 style='border-top:none'><%=tot14%></td>
  <td class=xl62 style='border-top:none'><%=tot15%></td>
  <td class=xl62 style='border-top:none'><%=tot16%></td>
  <td class=xl62 style='border-top:none'><%=tot17%></td>
  <td class=xl62 style='border-top:none'><%=tot18%></td>
  <td class=xl62 style='border-top:none' ><%=tot19%></td>
  <td class=xl62 style='border-top:none' ><%=tot20%></td>
  <td class=xl62 style='border-top:none' ><%=tot21%></td>
  <td class=xl62 style='border-top:none' ><%=tot22%></td>
  <td class=xl62 style='border-top:none'><%=tot23%></td>
  <td class=xl62 style='border-top:none'><%=tot24%></td>
  <td class=xl62 style='border-top:none'><%=tot25%></td>
  <td class=xl62 style='border-top:none'><%=tot26%></td>
  <td class=xl62 style='border-top:none'><%=tot27%></td>
  <td class=xl62 style='border-top:none'><%=tot28%></td>
  <td class=xl79 style='border-top:none'><%=tot29%></td>
  <td class=xl79 style='border-top:none'><%=tot30%></td>
  <td class=xl79 style='border-top:none'><%=tot31%></td>
  <td class=xl63 style='border-top:none'></td>
  <td colspan=34 class=xl47 style='mso-ignore:colspan'></td>
 </tr>

 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=6 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=6 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=29 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=35 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=124 style='width:93pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
