<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string _date = Request.QueryString["day"];
    string _prod_date = "";
    string SQL = "select to_char(to_date('" + _date + "','yyyymmdd'), 'DD-MON-YYYY') prod_date from dual";
    int row = 8;
    
    DataTable dt, dt1, dt2, dt3, dt4, dt5,dt6,dt7,dt8,dt9;
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        _prod_date = dt.Rows[0]["prod_date"].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpgm00066_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpgm00066_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpgm00066_1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>CTY TIN HOC HOANG KHA </o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-04-27T09:47:30Z</o:LastPrinted>
  <o:Created>2010-04-27T07:27:24Z</o:Created>
  <o:LastSaved>2010-05-06T08:41:12Z</o:LastSaved>
  <o:Company>DT:0650.35559627</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .16in .18in .81in;
	mso-header-margin:.23in;
	mso-footer-margin:.18in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
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
.xl24
	{mso-style-parent:style0;
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";}
.xl33
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl79
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl105
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl106
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl108
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl130
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl131
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl134
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl135
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl143
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl144
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl145
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl149
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl150
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl151
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl152
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl153
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl155
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl156
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl157
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl159
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl160
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl161
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl162
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl163
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl164
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl165
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl166
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl167
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl168
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl169
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl170
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl171
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:black;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	background:black;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style0;
	color:white;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:right;
	background:black;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";}
.xl176
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl178
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl179
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl180
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl184
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl187
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl188
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl189
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl190
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl191
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl192
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl193
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl194
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl195
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl197
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl198
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl199
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl200
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl201
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl202
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl203
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl204
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl205
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl206
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl207
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl208
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl209
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl210
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl211
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl212
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl213
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl214
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl215
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl216
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl217
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl218
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl219
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl220
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl221
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl222
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl223
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl224
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl225
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl226
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl227
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl228
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl229
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl230
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl231
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl232
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl233
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl234
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl235
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl236
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl237
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl238
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl239
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl240
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl241
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl242
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl243
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl244
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl245
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl246
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl247
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl248
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl249
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl250
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl251
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl252
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl253
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl254
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl255
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl256
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl257
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl258
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl259
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl260
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl261
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl262
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl263
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl264
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl265
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl266
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl267
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl268
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl269
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl270
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl271
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl272
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl273
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl274
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl275
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl276
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl277
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl278
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl279
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl280
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl281
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl282
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl283
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl284
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl285
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl286
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl287
	{mso-style-parent:style16;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl288
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl289
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl290
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl291
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl292
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl293
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl294
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl295
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl296
	{mso-style-parent:style16;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl297
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl298
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl299
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl300
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl301
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl302
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl303
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl304
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;}
.xl305
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl306
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl307
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl308
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl309
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl310
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl311
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl312
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl313
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl314
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl315
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl316
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl317
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl318
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl319
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl320
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl321
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl322
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl323
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl324
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl325
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl326
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl327
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl328
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl329
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl330
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl331
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl332
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl333
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl334
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl335
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl336
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl337
	{mso-style-parent:style0;
	font-size:20.0pt;}
.xl338
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl339
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl340
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl341
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl342
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl343
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl344
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>55</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>48</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>14880</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2017 style='border-collapse:
 collapse;table-layout:fixed;width:1517pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:2880;
 width:68pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:3648;
 width:86pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl24 width=77 span=2 style='mso-width-source:userset;mso-width-alt:
 2464;width:58pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3424;
 width:80pt'>
 <col class=xl25 width=46 style='mso-width-source:userset;mso-width-alt:1472;
 width:35pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl25 width=46 style='mso-width-source:userset;mso-width-alt:1472;
 width:35pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl26 width=46 style='mso-width-source:userset;mso-width-alt:1472;
 width:35pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl27 width=65 style='mso-width-source:userset;mso-width-alt:2080;
 width:49pt'>
 <col class=xl27 width=151 style='mso-width-source:userset;mso-width-alt:4832;
 width:113pt'>
 <col class=xl24 width=267 style='mso-width-source:userset;mso-width-alt:8544;
 width:200pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:2816;
 width:66pt'>
 <col class=xl24 width=71 span=239 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <tr class=xl327 height=54 style='mso-height-source:userset;height:40.5pt'>
  <td colspan=16 height=54 width=1716 style='height:40.5pt;width:1292pt'
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
   margin-left:369.75pt;margin-top:4.5pt;width:75.75pt;height:30pt;z-index:1'>
   <v:imagedata src="rpt_fpgm00066_1_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:493px;margin-top:6px;width:101px;
  height:40px'><img width=101 height=40 src="rpt_fpgm00066_1_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=16 height=54 class=xl336 width=1716 style='height:40.5pt;
    width:1292pt'>S&amp;J HOSIERY(VIETNAM) Co.,LTD</td>
   </tr>
  </table>
  </span></td>
  <td class=xl325 width=88 style='width:66pt'></td>
  <td class=xl325 width=71 style='width:53pt'></td>
  <td class=xl326 width=71 style='width:53pt'></td>
  <td class=xl325 width=71 style='width:53pt'></td>
 </tr>
 <tr class=xl106 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=16 height=40 class=xl338 style='height:30.0pt'>DAILY PRODUCTION
  REPORT</td>
  <td colspan=2 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl105></td>
  <td class=xl104></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl28 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl28></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td class=xl28></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'></td>
  <td class=xl32></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl33></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td class=xl28></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=27 style='height:20.25pt'>
  <td height=27 class=xl171 style='height:20.25pt'>DATE :</td>
  <td class=xl172 x:num><%=_prod_date %></td>
  <td class=xl174>UNIT :</td>
  <td class=xl173>PRS.</td>
  <td class=xl35></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td class=xl35></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl122 style='height:24.95pt'>KNITTING SECTION</span></td>
  <td class=xl123 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl339 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl118 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl119 style='border-left:none'>&nbsp;</td>
  <td class=xl117 style='border-left:none'>&nbsp;</td>
  <td class=xl120 style='border-left:none'>&nbsp;</td>
  <td class=xl121 style='border-left:none'>&nbsp;</td>
  <td rowspan=3 class=xl313 style='border-bottom:1.0pt solid black'>REMARKS</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl341 style='border-bottom:.5pt solid black;
  height:30.0pt;border-top:none'>Needle</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>M/C Q'TY</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=2 class=xl343 style='border-right:.5pt solid black;border-left:
  none'>M/C RUNNING</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>PROD. Q'TY</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>RE-KNITTING</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>B-GRADE</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>C-GRADE</td>
  <td rowspan=2 class=xl332 style='border-bottom:.5pt solid black;border-top:
  none' x:str="%"><span style='mso-spacerun:yes'> </span>%<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl329 style='border-bottom:.5pt solid black;border-top:
  none'>TOTAL PROD.</td>
  <td rowspan=2 class=xl332 style='border-bottom:.5pt solid black;border-top:
  none' x:str="%"><span style='mso-spacerun:yes'> </span>%<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl334 style='border-bottom:.5pt solid black;border-top:
  none'>MINI WHS STOCK</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 width=77 style='height:15.0pt;border-top:none;
  border-left:none;width:58pt'>day shift</td>
  <td class=xl48 width=77 style='border-top:none;border-left:none;width:58pt'>night
  shift</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
     dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpgm00066_1", _date);
     
     for (int i = 0; i < dt1.Rows.Count; i++)
     {  
 %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl107 style='height:20.1pt;border-top:none'><%=dt1.Rows[i]["line_name"] %></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>61</td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["target_qty"] %></td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt1.Rows[i]["prod_qty"] %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt1.Rows[i]["re_knit_qt"] %></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num x:fmla="=(F<%=row+i+1 %>+G<%=row+i+1 %>)/C<%=row+i+1 %>"></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt1.Rows[i]["quality"]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num x:fmla="=I<%=row+i+1 %>/(F<%=row+i+1 %>+G<%=row+i+1 %>)"></td>
  <td class=xl41 style='border-left:none'><%=dt1.Rows[i]["damage"]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num x:fmla="=K<%=row+i+1 %>/(F<%=row+i+1 %>+G<%=row+i+1 %>)"></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num x:fmla="=F<%=row+i+1 %>+G<%=row+i+1 %>+I<%=row+i+1 %>+K<%=row+i+1 %>"></td>
  <td class=xl42 style='border-left:none' x:num x:fmla="=M<%=row+i+1 %>/C<%=row+i+1 %>"></td>
  <td class=xl108 style='border-top:none'>&nbsp;</td>
  <td class=xl315 width=267 style='border-left:none;width:200pt'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
  <%
     }
     row = row + dt1.Rows.Count + 1;
%>

 <tr class=xl35 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl109 style='height:23.1pt;border-top:none'>TOTAL</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>&nbsp;</td>
  <td class=xl111 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-left:none'>&nbsp;</td>
  <td class=xl115 style='border-left:none'>&nbsp;</td>
  <td class=xl116>&nbsp;</td>
  <td class=xl318 style='border-left:none'>7AM ~7AM<span
  style='mso-spacerun:yes'>  </span>(2 shift)</td>
  <td class=xl47></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl125 style='height:8.1pt;border-top:none'>&nbsp;</td>
  <td class=xl126 style='border-top:none'>&nbsp;</td>
  <td class=xl127 style='border-top:none'>&nbsp;</td>
  <td class=xl127 style='border-top:none'>&nbsp;</td>
  <td class=xl127 style='border-top:none'>&nbsp;</td>
  <td class=xl128 style='border-top:none'>&nbsp;</td>
  <td class=xl128 style='border-top:none'>&nbsp;</td>
  <td class=xl129 style='border-top:none'>&nbsp;</td>
  <td class=xl128 style='border-top:none'>&nbsp;</td>
  <td class=xl129 style='border-top:none'>&nbsp;</td>
  <td class=xl128 style='border-top:none'>&nbsp;</td>
  <td class=xl129 style='border-top:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none'>&nbsp;</td>
  <td class=xl131 style='border-top:none'>&nbsp;</td>
  <td class=xl132 style='border-top:none'>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl47></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl137 style='height:24.95pt'>LINKIN<span
  style='display:none'>G SECTION</span></td>
  <td class=xl138 style='border-left:none'>&nbsp;</td>
  <td class=xl139 style='border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-left:none'>&nbsp;</td>
  <td class=xl141 style='border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td class=xl143 style='border-left:none'>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-left:none'>&nbsp;</td>
  <td class=xl144 style='border-left:none'>&nbsp;</td>
  <td class=xl140 style='border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-left:none'>&nbsp;</td>
  <td class=xl146 style='border-left:none'>&nbsp;</td>
  <td class=xl313 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl147 style='height:30.0pt;border-top:none'>Line</td>
  <td class=xl133 style='border-top:none;border-left:none'>M/C Q'TY</td>
  <td class=xl133 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl134 width=77 style='border-top:none;border-left:none;width:58pt'>M/C
  RUNNING</td>
  <td class=xl134 width=77 style='border-top:none;border-left:none;width:58pt'>&nbsp;</td>
  <td class=xl133 style='border-top:none;border-left:none'>PROD. Q'TY</td>
  <td class=xl133 style='border-top:none;border-left:none'>RE-LOOPING</td>
  <td class=xl133 style='border-top:none;border-left:none'>%</td>
  <td class=xl133 style='border-top:none;border-left:none'>MENDING</td>
  <td class=xl133 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-top:none;border-left:none'>CUTTER</td>
  <td class=xl135 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-top:none;border-left:none'>DAMAGE</td>
  <td class=xl136 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl148 style='border-left:none'>&nbsp;</td>
  <td class=xl314 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl107 style='height:20.1pt;border-top:none'>Line 1</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>10</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1027" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:3'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1029" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:5'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1031" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:7'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1033" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:9'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1035" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:11'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1037" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:13'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1039" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:15'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1041" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:14.25pt;width:7.5pt;height:16.5pt;z-index:17'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1026" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:2'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1028" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:4'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1030" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:6'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1032" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:8'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1034" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:10'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1036" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:12'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1038" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:14'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1040" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:16'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:18'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1043" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:19'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1044" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:20'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1045" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:21'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1046" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:22'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1047" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:23'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1048" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:24'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1049" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:25'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1066" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:42'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1067" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:43'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1068" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:44'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1069" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:45'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1070" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:46'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1071" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:47'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1072" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:48'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1073" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:33.75pt;width:7.5pt;height:16.5pt;z-index:49'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1050" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:26'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1051" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:27'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1052" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:28'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1053" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:29'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1054" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:30'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1055" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:31'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1056" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:32'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1057" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:33'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1074" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:50'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1075" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:51'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1076" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:52'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1077" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:53'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1078" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:54'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1079" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:55'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1080" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:56'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1081" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:53.25pt;width:7.5pt;height:16.5pt;z-index:57'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1058" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:34'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1059" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:35'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1060" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:36'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1061" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:37'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1062" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:38'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1063" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:39'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1064" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:40'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1065" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:41'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1082" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:58'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1083" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:59'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1084" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:60'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1085" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:61'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1086" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:62'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1087" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:63'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1088" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:64'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1089" type="#_x0000_t202" style='position:absolute;
   margin-left:90pt;margin-top:72.75pt;width:7.5pt;height:16.5pt;z-index:65'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto;mso-fit-shape-to-text:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:3;margin-left:120px;margin-top:19px;width:10px;
  height:100px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=10></td>
   </tr>
   <tr>
    <td height=22></td>
    <td align=left valign=top><img width=10 height=22
    src="rpt_fpgm00066_1_files/image003.gif" v:shapes="_x0000_s1027 _x0000_s1029 _x0000_s1031 _x0000_s1033 _x0000_s1035 _x0000_s1037 _x0000_s1039 _x0000_s1041"></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
   <tr>
    <td height=22></td>
    <td align=left valign=top><img width=10 height=22
    src="rpt_fpgm00066_1_files/image003.gif" v:shapes="_x0000_s1026 _x0000_s1028 _x0000_s1030 _x0000_s1032 _x0000_s1034 _x0000_s1036 _x0000_s1038 _x0000_s1040 _x0000_s1042 _x0000_s1043 _x0000_s1044 _x0000_s1045 _x0000_s1046 _x0000_s1047 _x0000_s1048 _x0000_s1049 _x0000_s1066 _x0000_s1067 _x0000_s1068 _x0000_s1069 _x0000_s1070 _x0000_s1071 _x0000_s1072 _x0000_s1073"></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
   <tr>
    <td height=22></td>
    <td align=left valign=top><img width=10 height=22
    src="rpt_fpgm00066_1_files/image003.gif" v:shapes="_x0000_s1050 _x0000_s1051 _x0000_s1052 _x0000_s1053 _x0000_s1054 _x0000_s1055 _x0000_s1056 _x0000_s1057 _x0000_s1074 _x0000_s1075 _x0000_s1076 _x0000_s1077 _x0000_s1078 _x0000_s1079 _x0000_s1080 _x0000_s1081"></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
   <tr>
    <td height=22></td>
    <td align=left valign=top><img width=10 height=22
    src="rpt_fpgm00066_1_files/image003.gif" v:shapes="_x0000_s1058 _x0000_s1059 _x0000_s1060 _x0000_s1061 _x0000_s1062 _x0000_s1063 _x0000_s1064 _x0000_s1065 _x0000_s1082 _x0000_s1083 _x0000_s1084 _x0000_s1085 _x0000_s1086 _x0000_s1087 _x0000_s1088 _x0000_s1089"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl49 align=right width=126 style='height:20.1pt;
    border-top:none;border-left:none;width:95pt' x:num="14000" x:fmla="=10*1400">14,000</td>
   </tr>
  </table>
  </span></td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G21+F21)/C21">0%</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td class=xl54></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl107 style='height:20.1pt;border-top:none'>Line 2</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="11000" x:fmla="=10*1100">11,000</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G22+F22)/C22">0%</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl150 style='height:20.1pt;border-top:none'>Line 3</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="9000" x:fmla="=10*900">9,000</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G23+F23)/C23">0%</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl150 style='height:20.1pt'>Line 4</td>
  <td class=xl55 style='border-left:none' x:num>10</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="9000" x:fmla="=10*900">9,000</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G24+F24)/C24">0%</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl150 style='height:20.1pt'>CONTI</td>
  <td class=xl55 style='border-left:none' x:num>2</td>
  <td class=xl56 align=right style='border-top:none;border-left:none'
  x:num="4000" x:fmla="=2000*2">4,000</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G25+F25)/C25">0%</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl150 style='height:20.1pt' x:str="ROSSO ">ROSSO<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl55 style='border-left:none' x:num>10</td>
  <td class=xl56 align=right style='border-left:none' x:num="36000"
  x:fmla="=12*3000">36,000</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G26+F26)/C26">0%</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl61 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl150 style='height:20.1pt'>HEMMING</td>
  <td class=xl55 style='border-left:none' x:num>1</td>
  <td class=xl56 align=right style='border-left:none' x:num>600</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=(G27+F27)/C27">0%</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl45 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl53 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl149 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl151 style='height:23.1pt'>TOTAL</td>
  <td class=xl152 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl153 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl156 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl159 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl160 style='border-left:none'>&nbsp;</td>
  <td class=xl318 style='border-left:none'>7AM~5PM</td>
  <td class=xl28></td>
  <td class=xl54></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl161 style='height:8.1pt'>&nbsp;</td>
  <td class=xl162 style='border-left:none'>&nbsp;</td>
  <td class=xl163 style='border-left:none'>&nbsp;</td>
  <td class=xl163 style='border-left:none'>&nbsp;</td>
  <td class=xl163 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl166 style='border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-left:none'>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl54></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl254 style='height:24.95pt'>INSPEC<span
  style='display:none'>TION SECTION</span></td>
  <td class=xl255 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl263 style='border-left:none'>&nbsp;</td>
  <td class=xl263 style='border-left:none'>&nbsp;</td>
  <td class=xl263 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl264 style='border-left:none'>&nbsp;</td>
  <td class=xl262 style='border-left:none'>&nbsp;</td>
  <td class=xl265 style='border-left:none'>&nbsp;</td>
  <td class=xl266 style='border-left:none'>&nbsp;</td>
  <td class=xl319 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl267 style='height:24.95pt;border-top:none'>RECORDER</td>
  <td class=xl252 style='border-top:none'>INSPECTOR</td>
  <td class=xl252 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl252 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl252 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl252 style='border-top:none;border-left:none'>PROD. Q'TY</td>
  <td class=xl252 style='border-top:none;border-left:none'>MENDING</td>
  <td class=xl252 style='border-top:none;border-left:none'>%</td>
  <td class=xl252 style='border-top:none;border-left:none'>B-GRADE</td>
  <td class=xl252 style='border-top:none;border-left:none'>%</td>
  <td class=xl252 style='border-top:none;border-left:none'>C-GRADE</td>
  <td class=xl253 style='border-top:none;border-left:none' x:str="%"><span
  style='mso-spacerun:yes'> </span>%<span style='mso-spacerun:yes'> </span></td>
  <td class=xl252 style='border-top:none;border-left:none'>TOTAL PROD.</td>
  <td class=xl268 style='border-top:none;border-left:none'>%</td>
  <td class=xl256 style='border-left:none'>MINI WHS STOCK</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl225 style='height:24.95pt;border-top:none'>IN001</td>
  <td class=xl101 style='border-top:none' x:num>47</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="47000" x:fmla="=B32*1000">47,000</td>
  <td class=xl63 style='border-left:none'>&nbsp;</td>
  <td class=xl63 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl89 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl175 x:num="0" x:fmla="=F32+K32"><span
  style='mso-spacerun:yes'>                           </span>-<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl66 style='border-top:none' x:num="0" x:fmla="=M32/C32">0%</td>
  <td class=xl176 style='border-left:none'>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td class=xl67 x:num="-42548" x:fmla="=O32-42548">-<span
  style='mso-spacerun:yes'>       </span>42,548 </td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl151 style='height:30.0pt;border-top:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl178 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl179>&nbsp;</td>
  <td class=xl179 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl152 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl159 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl180 style='border-left:none'>&nbsp;</td>
  <td class=xl318 style='border-left:none'>7AM~5PM</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl161 style='height:8.1pt'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl187 style='border-left:none'>&nbsp;</td>
  <td class=xl188>&nbsp;</td>
  <td class=xl188 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl162 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl189 style='border-left:none'>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl198 style='height:24.95pt'>SETTIN<span
  style='display:none'>G SECTION</span></td>
  <td class=xl199 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl201 style='border-left:none'>&nbsp;</td>
  <td class=xl201 style='border-left:none'>&nbsp;</td>
  <td class=xl201 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl202 style='border-left:none'>&nbsp;</td>
  <td class=xl200 style='border-left:none'>&nbsp;</td>
  <td class=xl203 style='border-left:none'>&nbsp;</td>
  <td class=xl204 style='border-left:none'>&nbsp;</td>
  <td class=xl319 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl205 style='height:24.95pt;border-top:none'>M/C</td>
  <td class=xl206 style='border-top:none;border-left:none'>OPERATOR</td>
  <td class=xl206 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl207 width=77 style='border-top:none;border-left:none;width:58pt'>&nbsp;</td>
  <td class=xl207 width=77 style='border-top:none;border-left:none;width:58pt'>&nbsp;</td>
  <td class=xl206 style='border-top:none;border-left:none'>PROD. Q'TY</td>
  <td class=xl206 style='border-top:none;border-left:none'>PRE-SETTING</td>
  <td class=xl206 style='border-top:none;border-left:none'>%</td>
  <td class=xl206 style='border-top:none;border-left:none'>WASHING</td>
  <td class=xl206 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl206 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl208 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl206 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl209 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl210 style='border-left:none'>&nbsp;</td>
  <td class=xl321 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>ST001</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="15000">15,000</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F37/C37">0%</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl191 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>ST002</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="15000">15,000</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F38/C38">0%</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl191 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>ST003</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="15000">15,000</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F39/C39">0%</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl192 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl193 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl192 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>7AM~5PM</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl151 style='height:23.1pt'>TOTAL</td>
  <td class=xl152 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl196 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl197 style='border-left:none'>&nbsp;</td>
  <td class=xl160 style='border-left:none'>&nbsp;</td>
  <td class=xl318 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl161 style='height:8.1pt'>&nbsp;</td>
  <td class=xl162 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl212 style='border-left:none'>&nbsp;</td>
  <td class=xl212 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl213 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl214 style='border-left:none'>&nbsp;</td>
  <td class=xl170 style='border-left:none'>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl269 style='height:24.95pt'>PAIRIN<span
  style='display:none'>G SECTION</span></td>
  <td class=xl270 style='border-left:none'>&nbsp;</td>
  <td class=xl271 style='border-left:none'>&nbsp;</td>
  <td class=xl272 style='border-left:none'>&nbsp;</td>
  <td class=xl272 style='border-left:none'>&nbsp;</td>
  <td class=xl273 style='border-left:none'>&nbsp;</td>
  <td class=xl272 style='border-left:none'>&nbsp;</td>
  <td class=xl274 style='border-left:none'>&nbsp;</td>
  <td class=xl274 style='border-left:none'>&nbsp;</td>
  <td class=xl274 style='border-left:none'>&nbsp;</td>
  <td class=xl272 style='border-left:none'>&nbsp;</td>
  <td class=xl275 style='border-left:none'>&nbsp;</td>
  <td class=xl272 style='border-left:none'>&nbsp;</td>
  <td class=xl276 style='border-left:none'>&nbsp;</td>
  <td class=xl277 style='border-left:none'>&nbsp;</td>
  <td class=xl319 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl278 style='height:24.95pt;border-top:none'>TABLE</td>
  <td class=xl279 style='border-top:none;border-left:none'>PAIRER</td>
  <td class=xl279 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl280 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl280 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl279 style='border-top:none;border-left:none'>PROD. Q'TY</td>
  <td class=xl328 style='border-top:none;border-left:none'>BACK SETTING</td>
  <td class=xl279 style='border-top:none;border-left:none'>%</td>
  <td class=xl279 style='border-top:none;border-left:none'>WASHING</td>
  <td class=xl279 style='border-top:none;border-left:none'>%</td>
  <td class=xl279 style='border-top:none;border-left:none'>MENDING</td>
  <td class=xl279 style='border-top:none;border-left:none'>%</td>
  <td class=xl279 style='border-top:none;border-left:none'>DAMAGE</td>
  <td class=xl279 style='border-top:none;border-left:none'>%</td>
  <td class=xl281>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PR001</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl56 align=right style='border-top:none;border-left:none'
  x:num="18000" x:fmla="=3000*6">18,000</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F45/C45">0%</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PR002</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl56 align=right style='border-left:none' x:num="18000"
  x:fmla="=3000*6">18,000</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F46/C46">0%</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PR003</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl56 align=right style='border-left:none' x:num="18000"
  x:fmla="=3000*6">18,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl216></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F47/C47">0%</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>7AM~5PM</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl151 style='height:20.1pt;border-top:none'>TOTAL</td>
  <td class=xl152 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-top:none;border-left:none' x:str="'0%">0%</td>
  <td class=xl217>&nbsp;</td>
  <td class=xl318 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl161 style='height:8.1pt'>&nbsp;</td>
  <td class=xl162 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl223 style='border-left:none'>&nbsp;</td>
  <td class=xl224>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl222 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl226 style='height:24.95pt'>CUTTIN<span
  style='display:none'>G SECTION</span></td>
  <td class=xl227 style='border-left:none'>&nbsp;</td>
  <td class=xl228 style='border-left:none'>&nbsp;</td>
  <td class=xl229 style='border-left:none'>&nbsp;</td>
  <td class=xl229 style='border-left:none'>&nbsp;</td>
  <td class=xl230 style='border-left:none'>&nbsp;</td>
  <td class=xl229 style='border-left:none'>&nbsp;</td>
  <td class=xl231 style='border-left:none'>&nbsp;</td>
  <td class=xl231 style='border-left:none'>&nbsp;</td>
  <td class=xl231 style='border-left:none'>&nbsp;</td>
  <td class=xl229 style='border-left:none'>&nbsp;</td>
  <td class=xl232 style='border-left:none'>&nbsp;</td>
  <td class=xl229 style='border-left:none'>&nbsp;</td>
  <td class=xl233 style='border-left:none'>&nbsp;</td>
  <td class=xl234 style='border-left:none'>&nbsp;</td>
  <td class=xl322 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl222 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl242 style='height:24.95pt;border-top:none'>TABLE</td>
  <td class=xl218 style='border-top:none'>CUTTER</td>
  <td class=xl218 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl219 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl219 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl218 style='border-top:none;border-left:none'>PROD. Q'TY</td>
  <td class=xl218 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl218 style='border-top:none;border-left:none'>%</td>
  <td class=xl218 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl218 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl218 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl220 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl218 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl221 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl235 style='border-left:none'>&nbsp;</td>
  <td class=xl321 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none' x:num>1</td>
  <td class=xl37 style='border-top:none' x:num>3</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="2000">2,000</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78></td>
  <td class=xl216></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F53/C53">0%</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl244 style='height:23.1pt;border-top:none'>TOTAL</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl236 style='border-left:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl241 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl283 style='height:20.1pt'>SEWIN<span style='display:
  none'>G SECTION</span></td>
  <td class=xl284>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl286 style='border-left:none'>&nbsp;</td>
  <td class=xl286 style='border-left:none'>&nbsp;</td>
  <td class=xl286 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl287 style='border-left:none'>&nbsp;</td>
  <td class=xl285 style='border-left:none'>&nbsp;</td>
  <td class=xl288 style='border-left:none'>&nbsp;</td>
  <td class=xl289 style='border-left:none'>&nbsp;</td>
  <td class=xl323 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl241 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl290 style='height:20.1pt;border-top:none'>M/C</td>
  <td class=xl246 style='border-top:none'>SEWER</td>
  <td class=xl246 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl247 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl247 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl246 style='border-top:none;border-left:none'>PROD.Q'TY</td>
  <td class=xl246 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl246 style='border-top:none;border-left:none'>%</td>
  <td class=xl246 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl246 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl246 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl248 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl246 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl249 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl291 style='border-left:none'>&nbsp;</td>
  <td class=xl321 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW001</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F57/C57">0%</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl237 style='border-top:none'>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW002</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F58/C58">0%</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl237 style='border-top:none'>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW003</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F59/C59">0%</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl238 style='border-top:none'>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW004</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F60/C60">0%</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl238>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW005</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F61/C61">0%</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl238>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>SW006</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl49 align=right style='border-top:none;border-left:none' x:num>600</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F62/C62">0%</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl238>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl193 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl238>&nbsp;</td>
  <td class=xl320 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl151 style='height:23.1pt'>TOTAL</td>
  <td class=xl152 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl154 style='border-left:none' x:num="0" x:fmla="=SUM(F57:F58)"><span
  style='mso-spacerun:yes'>                          </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl239 style='border-left:none'>&nbsp;</td>
  <td class=xl240>&nbsp;</td>
  <td class=xl318 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl161 style='height:8.1pt'>&nbsp;</td>
  <td class=xl162 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl223 style='border-left:none'>&nbsp;</td>
  <td class=xl224>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl241 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl292 style='height:24.95pt'>LABEL <span
  style='display:none'>SECTION</span></td>
  <td class=xl293 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl295 style='border-left:none'>&nbsp;</td>
  <td class=xl295 style='border-left:none'>&nbsp;</td>
  <td class=xl295 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl296 style='border-left:none'>&nbsp;</td>
  <td class=xl294 style='border-left:none'>&nbsp;</td>
  <td class=xl297 style='border-left:none'>&nbsp;</td>
  <td class=xl298 style='border-left:none'>&nbsp;</td>
  <td class=xl324 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl241 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl299 style='height:24.95pt;border-top:none'>M/C</td>
  <td class=xl300 style='border-top:none;border-left:none'>LABELER</td>
  <td class=xl300 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl301 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl301 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl300 style='border-top:none;border-left:none'>LABEL Q'TY</td>
  <td class=xl300 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl300 style='border-top:none;border-left:none'>%</td>
  <td class=xl300 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl300 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl300 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl302 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl300 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl303 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl304 style='border-left:none'>&nbsp;</td>
  <td class=xl321 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none'>LA001</td>
  <td class=xl37 style='border-top:none'>LA001</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="10000">10,000</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F68/C68">0%</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none'>LA002</td>
  <td class=xl37 style='border-top:none'>LA002</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="10000">10,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F69/C69">0%</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none'>LA003</td>
  <td class=xl37 style='border-top:none'>LA003</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="10000">10,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F70/C70">0%</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none'>LA004</td>
  <td class=xl37 style='border-top:none'>LA004</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="10000">10,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F71/C71">0%</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl243 style='height:20.1pt;border-top:none'>LA005</td>
  <td class=xl55 style='border-top:none'>BY HAND</td>
  <td class=xl56 align=right style='border-top:none;border-left:none'
  x:num="30000">30,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F72/C72">0%</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>7AM~5PM</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl151 style='height:20.1pt;border-top:none'>TOTAL</td>
  <td class=xl152 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl260>&nbsp;</td>
  <td class=xl195>&nbsp;</td>
  <td class=xl195 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl261 style='border-left:none'>&nbsp;</td>
  <td class=xl155 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl113 style='border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl245 style='border-left:none'>&nbsp;</td>
  <td class=xl217 style='border-left:none'>&nbsp;</td>
  <td class=xl318 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl35 style='height:8.1pt'></td>
  <td class=xl162>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl211 style='border-left:none'>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl212>&nbsp;</td>
  <td class=xl212 style='border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-left:none'>&nbsp;</td>
  <td class=xl250 style='border-left:none'>&nbsp;</td>
  <td class=xl251 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl186 style='border-left:none'>&nbsp;</td>
  <td class=xl223 style='border-left:none'>&nbsp;</td>
  <td class=xl224>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl241 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl184 style='height:24.95pt'>PACKIN<span
  style='display:none'>G SECTION</span></td>
  <td class=xl185 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl306 style='border-left:none'>&nbsp;</td>
  <td class=xl306 style='border-left:none'>&nbsp;</td>
  <td class=xl306 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl307 style='border-left:none'>&nbsp;</td>
  <td class=xl305 style='border-left:none'>&nbsp;</td>
  <td class=xl308 style='border-left:none'>&nbsp;</td>
  <td class=xl309>&nbsp;</td>
  <td class=xl324 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl241 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl310 style='height:24.95pt;border-top:none'>PACKING</td>
  <td class=xl181 style='border-top:none;border-left:none'>PACKER</td>
  <td class=xl181 style='border-top:none;border-left:none'>TARGET Q'TY</td>
  <td class=xl282 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl282 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none'>PACKED Q'TY</td>
  <td class=xl181 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl311 style='border-top:none;border-left:none'>%</td>
  <td class=xl181 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl182 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl312 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl183 style='border-top:none'>&nbsp;</td>
  <td class=xl321 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PK001</td>
  <td class=xl37 style='border-top:none;border-left:none'>OIC-PHUNG</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="20000">20,000</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 align=right style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F77/C77">0%</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl215 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>7AM~5PM</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PK002</td>
  <td class=xl37 style='border-top:none;border-left:none'>OIC-LAN</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="20000">20,000</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 align=right style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F78/C78">0%</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl257 style='border-top:none'>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PK003</td>
  <td class=xl37 style='border-top:none;border-left:none'>OIC-CHUNG</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="20000">20,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl100 align=right style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F79/C79">0%</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl257>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl190 style='height:20.1pt;border-top:none'>PK004</td>
  <td class=xl37 style='border-top:none;border-left:none'>OIC-LUAN</td>
  <td class=xl49 align=right style='border-top:none;border-left:none'
  x:num="20000">20,000</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl100 align=right style='border-top:none;border-left:none' x:num="0"
  x:fmla="=F80/C80">0%</td>
  <td class=xl87 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl257>&nbsp;</td>
  <td class=xl317 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 class=xl151 style='height:23.1pt;border-top:none'>TOTAL</td>
  <td class=xl152 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl179 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl194 style='border-left:none'>&nbsp;</td>
  <td class=xl258 style='border-left:none'>&nbsp;</td>
  <td class=xl259>&nbsp;</td>
  <td class=xl318 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl28 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl99></td>
  <td class=xl28></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td class=xl28></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl27></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=7 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=7 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
