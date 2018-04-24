<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
<link rel=File-List href="Page_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="Daily report 2_28667_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl2428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4928667
	{padding:0px;
	mso-ignore:padding;
	color:purple;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5028667
	{padding:0px;
	mso-ignore:padding;
	color:green;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline black;
	border-left:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5428667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5528667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5928667
	{padding:0px;
	mso-ignore:padding;
	color:green;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(\[$USD\]\\ * \#\,\#\#0\.00_\)\;_\(\[$USD\]\\ * \\\(\#\,\#\#0\.00\\\)\;_\(\[$USD\]\\ * \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(\[$VND\]\\ * \#\,\#\#0_\)\;_\(\[$VND\]\\ * \\\(\#\,\#\#0\\\)\;_\(\[$VND\]\\ * \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7428667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7528667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7628667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7728667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7828667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7928667
	{padding:0px;
	mso-ignore:padding;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8228667
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:22.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8328667
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl9828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl11028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl11128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11528667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11628667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11728667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11828667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11928667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12028667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12128667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12228667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12328667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12428667
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>
<%
    string strCompk = "", strFormType = "";    
    string strParam = "";
    //counter param
    int i, j;
    string strFrom = "", strTo = "", strStatus = "" ;
    strCompk = Request["company"];
    strFrom = Request["dtbFrom"];
    strTo = Request["dtbTo"];
    strStatus = Request["status"];
    // company name
    string strCompNM = "", strCompTel = "", strCompAddr = "", strCompFax = "";
    string SQL = "";
    SQL = "select partner_lname, nvl(addr1, '') || nvl(addr2, ' ') || nvl(addr3, '') addr, phone_no, fax_no, TCO_BPPHOTO_PK from tco_company where pk = '" + strCompk + "'";
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count > 0)
    {
        strCompNM = dtComp.Rows[0][0].ToString();
        strCompAddr = dtComp.Rows[0][1].ToString();
        strCompTel = dtComp.Rows[0][2].ToString();
        strCompFax = dtComp.Rows[0][3].ToString();
    }    
    // print date
    string strDay = DateTime.Today.Day.ToString();
    string strMonth = DateTime.Today.Month.ToString();
    string strYear = DateTime.Today.Year.ToString();    
    // Acc. Code
    SQL
        = "      SELECT  " +
            "             A.TAC_ABACCTCODE_PK, ac_get_ACNM(A.TAC_ABACCTCODE_PK, '" + strCompk + "', 'ENG'),  " +
            "             C.AC_CD_FORMULAR, C.REMARK, C.CCY " +
            "        FROM TAC_KAFINANCEFORM A, TAC_ABACCTCODE C " +
            "       WHERE A.DEL_IF = 0 " +
            "         AND (A.PRN_LEVEL LIKE DECODE(TRIM(''), '', '%', '') OR '' IS NULL) " +
            "         AND A.FORM_TYPE       = '62' " +
            "         AND A.TCO_COMPANY_PK  like  DECODE ('" + strCompk + "', 0, '%%', '" + strCompk + "')"+
            "         AND A.TAC_ABACCTCODE_PK = C.PK " +
            "       ORDER BY C.REMARK, PRN_SEQ ";
    DataTable dtTK = new DataTable();
    dtTK = ESysLib.TableReadOpen(SQL);
    string strAcGrp = "", strCCY = "", strACNM = "";
    string strACCD = "";
    // sum amount
    string l_beg_amt = "0", l_rcv_amt = "0", l_pay_amt = "0", l_end_amt = "0";
    
 %>
<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Daily report 2_28667" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1164 class=xl2428667
 style='border-collapse:collapse;table-layout:fixed;width:875pt'>
 <col class=xl2428667 width=103 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl2428667 width=40 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl2428667 width=180 style='mso-width-source:userset;mso-width-alt:
 6582;width:135pt'>
 <col class=xl8128667 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl2428667 width=110 span=4 style='mso-width-source:userset;
 mso-width-alt:4022;width:83pt'>
 <col class=xl2428667 width=88 style='mso-width-source:userset;mso-width-alt:
 3218;width:66pt'>
 <col class=xl2428667 width=79 style='mso-width-source:userset;mso-width-alt:
 2889;width:59pt'>
 <col class=xl2428667 width=64 style='width:48pt'>
 <col class=xl2528667 width=84 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 width=103 style='height:27.75pt;width:77pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:17.25pt;margin-top:0;width:56.25pt;height:57pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dtComp.Rows[0][4].ToString()%>&table_name=tco_bpphoto" o:title=""/>
   <o:lock v:ext="edit" aspectratio="f"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:23px;margin-top:0px;width:75px;
  height:76px'><img width=75 height=76
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dtComp.Rows[0][4].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=37 class=xl2428667 width=103 style='height:27.75pt;width:77pt'
    x:str="     "><span style='mso-spacerun:yes'>     </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl8428667 width=746 style='width:562pt'><%=strCompNM%></td>
  <td class=xl2428667 width=88 style='width:66pt'></td>
  <td class=xl2428667 width=79 style='width:59pt'></td>
  <td class=xl2428667 width=64 style='width:48pt'></td>
  <td class=xl2528667 width=84 style='width:63pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2428667 style='height:15.75pt'></td>
  <td colspan=7 class=xl8528667><%=strCompAddr%></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2428667 style='height:15.75pt'></td>
  <td class=xl2628667 colspan=2 x:str><%=strCompTel %><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl2628667></td>
  <td class=xl2628667></td>
  <td class=xl2728667 x:str><%=strCompFax%><span style='mso-spacerun:yes'>              </span></td>
  <td class=xl2728667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl2828667 style='height:11.25pt'>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2928667>&nbsp;</td>
  <td class=xl2828667>&nbsp;</td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=8 height=29 class=xl8228667 style='height:21.75pt'
  x:str>DAILY BALANCE<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td colspan=8 height=24 class=xl8328667 style='height:18.0pt'
  x:str>From <%= strFrom.Substring(6, 2) + "/" + strFrom.Substring(4, 2) + "/" + strFrom.Substring(0, 4) %> to <%=strTo.Substring(6, 2) + "/" + strTo.Substring(4, 2) + "/" + strTo.Substring(0, 4)%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3028667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl3128667 style='height:18.0pt'>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3128667>&nbsp;</td>
  <td class=xl3028667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl8628667 style='height:23.25pt'>DESCRIPTION</td>
  <td class=xl3228667 style='border-top:none'>Bank Code</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Beg- balance</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Received</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Payment</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>End- Balance</td>
  <td class=xl3328667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 
 <%
     decimal l_tot_beg_amt_vnd = 0, l_tot_beg_amt_usd = 0;
     decimal l_tot_rev_amt_vnd = 0, l_tot_rev_amt_usd = 0;
     decimal l_tot_pay_amt_vnd = 0, l_tot_pay_amt_usd = 0;
     decimal l_tot_end_amt_vnd = 0, l_tot_end_amt_usd = 0;
     SQL = "select d.code from tac_commcode_master a, tac_commcode_detail d where a.pk =  d.tac_commcode_master_pk and a.id = 'ACBG0040' and d.del_if = 0 and d.def_yn = 'Y'";
     DataTable dtBookCcy = ESysLib.TableReadOpen(SQL);
     string ls_bookccy = "";
     if (dtBookCcy.Rows.Count > 0)
     {
         ls_bookccy = dtBookCcy.Rows[0][0].ToString();
     }         
     strParam = "'" + strCompk + "','VIE','" + strFrom.Substring(0, 6) + "','" + strTo.Substring(0, 6) + "','" + strStatus + "','USD','1','','','','0','ALL','62'";
     DataTable dtSumAmt = ESysLib.TableReadOpenCursor("ac_SEL_60080140_DTL_LEDGERS", strParam);
     for(i = 1; i < dtSumAmt.Rows.Count; i++)
     {
         SQL = "select ccy, remark from tac_abacctcode where pk = '" + dtSumAmt.Rows[i][1].ToString() + "'";
         DataTable dtAcc = ESysLib.TableReadOpen(SQL);
         strAcGrp = dtAcc.Rows[0][1].ToString();
         strCCY = dtAcc.Rows[0][0].ToString();
         strACNM = dtSumAmt.Rows[i][22].ToString();
         strACCD = dtSumAmt.Rows[i][21].ToString(); // account code
             
                 if (dtSumAmt.Rows[i][5].ToString() != "")
                 {
                     l_beg_amt = dtSumAmt.Rows[i][5].ToString();
                 }
                 else
                 {
                     l_beg_amt = "0";   
                 }
                 if(strCCY == "VND")
                 {
                     l_tot_beg_amt_vnd += decimal.Parse(l_beg_amt.Replace(",", ""));   
                 }
                 else if (strCCY == "USD")
                 {
                     l_tot_beg_amt_usd += decimal.Parse(l_beg_amt.Replace(",", ""));    
                 }    
                 if (dtSumAmt.Rows[i][9].ToString() != "")
                 {
                     l_rcv_amt = dtSumAmt.Rows[i][9].ToString();
                 }
                 else
                 {
                     l_rcv_amt = "0";
                 }
                 if (strCCY == "VND")
                 {
                     l_tot_rev_amt_vnd += decimal.Parse(l_rcv_amt.Replace(",", ""));
                 }
                 else if (strCCY == "USD")
                 {
                     l_tot_rev_amt_usd += decimal.Parse(l_rcv_amt.Replace(",", ""));
                 }
                 if (dtSumAmt.Rows[i][10].ToString() != "")
                 {
                     l_pay_amt = dtSumAmt.Rows[i][10].ToString();
                 }
                 else
                 {
                     l_pay_amt = "0";
                 }
                 if (strCCY == "VND")
                 {
                     l_tot_pay_amt_vnd += decimal.Parse(l_pay_amt.Replace(",", ""));
                 }
                 else if (strCCY == "USD")
                 {
                     l_tot_pay_amt_usd += decimal.Parse(l_pay_amt.Replace(",", ""));
                 }                 
                 
                 if (dtSumAmt.Rows[i][17].ToString() != "")
                 {
                     l_end_amt = dtSumAmt.Rows[i][17].ToString();
                 }
                 else
                 {
                     l_end_amt = "0";
                 }
                 if (strCCY == "VND")
                 {
                     l_tot_end_amt_vnd += decimal.Parse(l_end_amt.Replace(",", ""));
                 }
                 else if (strCCY == "USD")
                 {
                     l_tot_end_amt_usd += decimal.Parse(l_end_amt.Replace(",", ""));
                 }                 
 %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 rowspan=1 height=20 class=xl8828667 style='border-top:.5pt solid black;border-bottom:none;
  height:20.0pt'><%=strAcGrp%></td>
  <td class=xl3428667 style='border-top:.5pt solid black;'><%=strACNM%></td>
  <td class=xl3428667 style='border-top:.5pt solid black'><%=strCCY%></td>
  <td class=xl3628667 style="border-top:.5pt solid black;" x:num><%=l_beg_amt %></td>
  <td class=xl3628667 style="border-top:.5pt solid black;" x:num><%=l_rcv_amt %></td>
  <td class=xl3628667 style="border-top:.5pt solid black;" x:num><%=l_pay_amt %></td>
  <td class=xl3628667 style="border-top:.5pt solid black" x:num><%=l_end_amt %></td>
  <td class=xl3328667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <%     
 }
 %>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 rowspan=2 height=56 class=xl9428667 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:42.0pt;border-top:.5pt solid black;'>TOTAL</td>
  <td class=xl5228667 style='border-left:none;border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl5328667 style="border-top:.5pt solid black;">USD</td>
  <td class=xl5428667 style="border-top:.5pt solid black " x:num><%=l_tot_beg_amt_usd %> </td>
  <td class=xl5528667 style="border-top:.5pt solid black" x:num><%=l_tot_rev_amt_usd%></td>
  <td class=xl5528667 style="border-top:.5pt solid black;" x:num><%=l_tot_pay_amt_usd%></td>
  <td class=xl5528667 style="border-top:.5pt solid black;" x:num><%=l_tot_end_amt_usd%></td>
  <td class=xl5028667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl5628667 style='height:21.0pt;border-top:none;
  border-left:none'>&nbsp;</td>
  <td class=xl5728667>VND</td>
  <td class=xl5828667 x:num><%=l_tot_beg_amt_vnd %> </td>
  <td class=xl5828667 x:num><%=l_tot_rev_amt_vnd %></td>
  <td class=xl5828667 x:num><%=l_tot_pay_amt_vnd%></td>
  <td class=xl5828667 x:num><%=l_tot_end_amt_vnd%> </td>
  <td class=xl5928667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl9828667 style='height:21.75pt'>For further
  information of receipt, please refer to the following detail:</td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl6028667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 rowspan=2 height=50 class=xl9928667 width=409 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:37.5pt;width:307pt'
  x:str="IN ADVANCE MONEY ">IN ADVANCE MONEY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl6128667 x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 rowspan=2 class=xl10528667 width=330 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:249pt'
  x:str="In advance money by staffs."><span style='mso-spacerun:yes'> </span>In
  advance money by staffs.<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl6228667 style='height:18.75pt' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr class=xl4128667 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl11128667 style='border-right:.5pt solid black;
  height:21.75pt'>Actual Balance After Deduct In- advance Money ( Including VND
  &amp; USD )</td>
  <td class=xl6328667>&nbsp;</td>
  <td class=xl6428667 x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl6528667 x:str="Ex. Rate :"><span
  style='mso-spacerun:yes'> </span>Ex. Rate :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl6628667 x:num="0"><span
  style='mso-spacerun:yes'>                              </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr class=xl4128667 height=34 style='height:25.5pt'>
  <td colspan=3 height=34 class=xl11428667 style='border-right:.5pt solid black;
  height:25.5pt'>RECEIVE FROM</td>
  <td class=xl6728667 style='border-top:none;border-left:none'>Seq</td>
  <td class=xl6728667 style='border-top:none;border-left:none'>Voucher No</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl6828667 width=110 style='border-top:none;border-left:none;
  width:83pt'>Receive by <br>
    cash on hand</td>
  <td class=xl6928667 width=110 style='border-top:none;width:83pt'>Receive by
  <br>
    cash in bank</td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <%
     string strBankYN = "";
     l_tot_rev_amt_vnd = 0;
     l_tot_rev_amt_usd = 0;
     decimal l_tot_revamt_vndcash = 0, l_tot_revamt_usdcash = 0;
     //for (i = 0; i < dtTK.Rows.Count; i++)
     //{
         SQL
           = " SELECT H.PK, TO_CHAR(H.TR_DATE,ac_get_FORMAT ('ACAB0300')) TR_DATE, H.VOUCHERNO,  " +
               "    ac_get_ACCD(R.TAC_ABACCTCODE_PK_DR,'" + strCompk + "') ACDR,  ac_get_ACCD(R.TAC_ABACCTCODE_PK_CR,'" + strCompk + "') ACCR,  " +
               "    R.TR_BOOKAMT, R.REMARK , R.REMARK2, R.TR_AMT, (SELECT D.CCY FROM TAC_HGTRD D WHERE D.PK = R.TAC_HGTRD_PK) CCY,   " +
            " DECODE( ( SELECT COUNT(*) FROM TAC_ABTRACGRP P, TAC_ABTRACGRPD D  " +
            " WHERE D.TAC_ABACCTCODE_PK =  R.TAC_ABACCTCODE_PK_DR " +
        " AND D.DEL_IF = 0 " +
        " AND D.TAC_ABTRACGRP_PK = P.PK " +
        " AND P.DEL_IF = 0 " +
        " AND P.AC_GRP = '112' ), 0, 'N', 'Y') BANK_YN " +                
               "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R  " +
               "    WHERE R.TAC_ABACCTCODE_PK_DR IN ( " +
               "               SELECT A.TAC_ABACCTCODE_PK " +
                " FROM TAC_KAFINANCEFORM A " +
               " WHERE A.DEL_IF = 0 " +                
                " AND A.FORM_TYPE       = '62' " +
                 " AND A.TCO_COMPANY_PK  like  DECODE ('" + strCompk + "', 0, '%%', '" + strCompk + "')"+
                 " ) " +                
               "    AND R.DEL_IF = 0  " +               
               "    AND R.DRCR_TYPE = 'D'   " +
               "    AND H.PK = R.TAC_HGTRH_PK  " +
               "    AND h.TCO_COMPANY_PK  like  DECODE ('" + strCompk + "', 0, '%%', '" + strCompk + "')"+
               "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + strFrom + "' AND '" + strTo + "'    " +
               "    AND H.TR_STATUS IN (DECODE (" + strStatus + " , 2, 2, " + strStatus + "),DECODE (" + strStatus + ", 2, 0, " + strStatus + "), DECODE (" + strStatus + ", 2, 4, " + strStatus + ")) " +               
               "  " +
               "  ORDER BY TR_DATE ASC,H.PK ";
         DataTable dtDetail = ESysLib.TableReadOpen(SQL);
         for (j = 0; j < dtDetail.Rows.Count; j++)
         {
             strBankYN = dtDetail.Rows[j][10].ToString();             
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 height=28 class=xl11128667 style='border-right:.5pt solid black;
  height:21.0pt'><%=dtDetail.Rows[j][7].ToString()%></td>
  <td class=xl7028667 style='border-left:none' x:num><%=dtDetail.Rows[j][0].ToString()%></td>
  <td class=xl7028667 style='border-left:none'><%=dtDetail.Rows[j][2].ToString()%></td>
  <td class=xl7028667 style='border-top:none;border-left:none'><%=dtDetail.Rows[j][9].ToString()%></td>
  <% 
     if (strBankYN == "N")
     {
         if (dtDetail.Rows[j][9].ToString() == "VND")
             l_tot_revamt_vndcash += decimal.Parse(dtDetail.Rows[j][8].ToString());
         else if (dtDetail.Rows[j][9].ToString() == "USD")
             l_tot_revamt_usdcash += decimal.Parse(dtDetail.Rows[j][5].ToString());
         if (dtDetail.Rows[j][9].ToString() == "VND")
         {
  %>
  <td class=xl7128667 style='border-top:none;border-left:none;' x:num><%=dtDetail.Rows[j][8].ToString()%></td>
  <% } 
     else { %>  
        <td class=xl7128667 style='border-top:none;border-left:none;' x:num><%=dtDetail.Rows[j][5].ToString()%></td>
    <% } %>        
  <td class=xl7128667 style='border-top:none;border-left:none' x:num> </td>
  <% 
     }
     else
     {
         if (dtDetail.Rows[j][9].ToString() != ls_bookccy)
             l_tot_rev_amt_vnd += decimal.Parse(dtDetail.Rows[j][8].ToString());
         else if (dtDetail.Rows[j][9].ToString() == ls_bookccy)
             l_tot_rev_amt_usd += decimal.Parse(dtDetail.Rows[j][5].ToString());                  
  %>
  <td class=xl7128667 style='border-top:none;border-left:none;' x:num></td>
  <% if (dtDetail.Rows[j][9].ToString() != ls_bookccy)
     { %>
    <td class=xl7128667 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][8].ToString()%></td>  
  <% }
     else
     { %>      
    <td class=xl7128667 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][5].ToString()%></td>  
  <% 
      }
     }
  %>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
<% 
     //}
 }         
%>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 rowspan=2 height=56 class=xl11828667 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:42.0pt'>TOTAL</td>
  <td class=xl7228667 style='border-top:none'>&nbsp;</td>
  <td class=xl7428667 style='border-top:none'>&nbsp;</td>
  <td class=xl7528667 style='border-top:none' x:str>VND</td>
  <td class=xl7628667 style='border-top:none' x:num><%=l_tot_revamt_vndcash%></td>
  <td class=xl7628667 style='border-top:none' x:num><%=l_tot_rev_amt_vnd%></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl7028667 style='height:21.0pt;border-top:none;
  border-left:none'>&nbsp;</td>
  <td class=xl7728667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl7828667 style='border-top:none;border-left:none' x:str>USD</td>
  <td class=xl7928667 style='border-top:none;border-left:none' x:num><%=l_tot_revamt_usdcash%> </td>
  <td class=xl7928667 style='border-top:none;border-left:none' x:num><%=l_tot_rev_amt_usd%></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr class=xl4128667 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl2828667 colspan=3 style='height:18.75pt'>For further
  information of payment , please refer to the f<span style='display:none'>ollowing
  detail:</span></td>
  <td class=xl7028667 style='border-top:none'>&nbsp;</td>
  <td class=xl7728667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl7828667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl7928667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl7928667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr class=xl4128667 height=34 style='height:25.5pt'>
  <td colspan=3 height=34 class=xl8628667 style='border-right:.5pt solid black;
  height:25.5pt'>DESCRIPTION</td>
  <td class=xl6728667 style='border-top:none;border-left:none'>Seq</td>
  <td class=xl6728667 style='border-top:none;border-left:none'>Voucher No</td>
  <td class=xl3228667 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl6828667 width=110 style='border-top:none;border-left:none;
  width:83pt'>Paid by<br>
    cash on hand</td>
  <td class=xl6928667 width=110 style='border-top:none;width:83pt'>Paid
  by<br>
    cash in bank</td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <%
      strBankYN = "";
     l_tot_rev_amt_vnd = 0;
     l_tot_rev_amt_usd = 0;
     l_tot_revamt_vndcash = 0; l_tot_revamt_usdcash = 0;
 SQL
	= " SELECT H.PK, TO_CHAR(H.TR_DATE,ac_get_FORMAT ('ACAB0300')) TR_DATE, H.VOUCHERNO,  " + 
        "    ac_get_ACCD(R.TAC_ABACCTCODE_PK_CR,'" + strCompk + "') ACDR,  ac_get_ACCD(R.TAC_ABACCTCODE_PK_DR,'" + strCompk + "') ACCR,  " +
        "    R.TR_BOOKAMT, R.REMARK , R.REMARK2, R.TR_AMT, " +
        "    (SELECT D.CCY FROM TAC_HGTRD D WHERE D.PK = R.TAC_HGTRD_PK) CCY,  " +
        "   DECODE( ( SELECT COUNT(*) FROM TAC_ABTRACGRP P, TAC_ABTRACGRPD D  " +
        "            WHERE D.TAC_ABACCTCODE_PK =  R.TAC_ABACCTCODE_PK_DR " +
        "        AND D.DEL_IF = 0  " +
        "        AND D.TAC_ABTRACGRP_PK = P.PK  " +
        "        AND P.DEL_IF = 0  " +
        "        AND P.AC_GRP = '112' ), 0, 'N', 'Y') BANK_YN   " +
        "FROM TAC_HGTRH H,  TAC_HGTRD_REF R " +
        "    WHERE H.DEL_IF = 0   " +
        "    AND R.DEL_IF = 0 " +
        "    AND R.TAC_ABACCTCODE_PK_DR     " +
        "    IN ( " +
        "                      SELECT A.TAC_ABACCTCODE_PK               " +
        "                FROM TAC_KAFINANCEFORM A " +
        "               WHERE A.DEL_IF = 0 " +
        "                 AND (A.PRN_LEVEL LIKE DECODE(TRIM(''), '', '%', '') OR '' IS NULL) " +
        "                 AND A.FORM_TYPE       = '62' " +
        "                 AND A.TCO_COMPANY_PK  = " + strCompk + 
        "        )        " +
        "    AND H.PK = R.TAC_HGTRH_PK  " +
        "    AND R.DRCR_TYPE = 'C'   " +
        "    AND h.TCO_COMPANY_PK  like  DECODE ('" + strCompk + "', 0, '%%', '" + strCompk + "')"+
        "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + strFrom + "' AND '" + strTo + "'    " +
        "    AND H.TR_STATUS IN (DECODE (" + strStatus + " , 2, 2, " + strStatus + "),DECODE (" + strStatus + ", 2, 0, " + strStatus + "), DECODE (" + strStatus + ", 2, 4, " + strStatus + ")) " +
        "  ORDER BY TR_DATE ASC,H.PK  " ;
        
         dtDetail = ESysLib.TableReadOpen(SQL);
     
         for (j = 0; j < dtDetail.Rows.Count; j++)
         {
             strBankYN = dtDetail.Rows[j][10].ToString();             
             if(strBankYN =="Y")
             {
                 if (dtDetail.Rows[j][9].ToString() != ls_bookccy)
                    l_tot_rev_amt_vnd += decimal.Parse(dtDetail.Rows[j][8].ToString());
                 else
                    l_tot_rev_amt_usd += decimal.Parse(dtDetail.Rows[j][5].ToString());
             }
             else
             {
                 if (dtDetail.Rows[j][9].ToString() == ls_bookccy)
                    l_tot_revamt_vndcash += decimal.Parse(dtDetail.Rows[j][8].ToString());
                 else
                    l_tot_revamt_usdcash += decimal.Parse(dtDetail.Rows[j][5].ToString());                 
             }
%>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 height=28 class=xl11128667 style='border-right:.5pt solid black;
  height:21.0pt'><%=dtDetail.Rows[j][7].ToString()%></td>
  <td class=xl7028667 style='border-left:none' x:num><%=dtDetail.Rows[j][0].ToString()%></td>
  <td class=xl7028667 style='border-left:none' x:str><%=dtDetail.Rows[j][2].ToString()%></td>
  <td class=xl7028667 style='border-top:none;border-left:none' x:str><%=dtDetail.Rows[j][9].ToString()%></td>
  <% 
     if (dtDetail.Rows[j][10].ToString() == "N")
     {
  %>
  <td class=xl7128667 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][8].ToString()%></td>
  <td class=xl7128667 style='border-top:none;border-left:none' x:num></td>
   <% 
     }
     else
     {
  %>
  <td class=xl7128667 style='border-top:none;border-left:none' x:num></td>
  <td class=xl7128667 style='border-top:none;border-left:none' x:num><%=dtDetail.Rows[j][8].ToString()%></td>
    <% 
    }
    %>  
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <% 
 }
 %>
 <tr class=xl4128667 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 rowspan=2 height=56 class=xl11828667 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:42.0pt'>TOTAL</td>
  <td class=xl7228667 style='border-top:none'>&nbsp;</td>
  <td class=xl7428667 style='border-top:none'>&nbsp;</td>
  <td class=xl7528667 style='border-top:none' x:str>VND</td>
  <td class=xl7628667 style='border-top:none' x:num><%=l_tot_revamt_vndcash %></td>
  <td class=xl7628667 style='border-top:none' x:num><%=l_tot_rev_amt_vnd %></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4128667></td>
  <td class=xl4228667></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl7028667 style='height:21.0pt;border-top:none;
  border-left:none'>&nbsp;</td>
  <td class=xl7728667 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl7828667 style='border-top:none;border-left:none' x:str>USD</td>
  <td class=xl7928667 style='border-top:none;border-left:none' x:num><%=l_tot_revamt_usdcash %></td>
  <td class=xl7928667 style='border-top:none;border-left:none' x:num><%=l_tot_rev_amt_usd %></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl2428667 style='height:28.5pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl8028667 style='height:12.75pt'>Prepared by :</td>
  <td class=xl8128667></td>
  <td class=xl8128667></td>
  <td colspan=2 class=xl8128667>Checked by</td>
  <td class=xl2428667></td>
  <td colspan=2 class=xl8128667>Approved by :</td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2428667 style='height:12.75pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2428667 style='height:12.75pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2428667 style='height:12.75pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2428667 style='height:12.75pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2428667 style='height:12.75pt'></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td colspan=2 class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl8128667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2428667></td>
  <td class=xl2528667></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=103 style='width:77pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
