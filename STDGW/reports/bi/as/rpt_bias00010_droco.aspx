<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    DataTable dt1 = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00010_1_droco", "'" + master_pk + "'");
    DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_bias00010", "'" + master_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="ddddddddd_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="rpt_bias00010_21002_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font521002
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font621002
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font721002
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.font821002
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.xl9921002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10021002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10421002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10521002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10621002
	{padding:0px;
	mso-ignore:padding;
	color:blue;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10721002
	{padding:0px;
	mso-ignore:padding;
	color:blue;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl10821002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl10921002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11021002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11421002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11521002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11621002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl11721002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11821002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl11921002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl12021002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12421002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl12521002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl12621002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl12721002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl12821002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl12921002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13021002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13421002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13521002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl13621002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13721002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13821002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl13921002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl14021002
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl14121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl14221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl14321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl14421002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:normal;}
.xl14521002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl14621002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl14721002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl14821002
{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl14921002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl15021002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:26.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl15121002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl15221002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl15321002
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="rpt_bias00010_21002" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1375 class=xl9921002
 style='border-collapse:collapse;table-layout:fixed;width:1035pt'>
 <col class=xl9921002 width=32 style='mso-width-source:userset;mso-width-alt:
 1024;width:24pt'>
 <col class=xl9921002 width=314 style='mso-width-source:userset;mso-width-alt:
 10048;width:236pt'>
 <col class=xl9921002 width=198 style='mso-width-source:userset;mso-width-alt:
 6336;width:149pt'>
 <col class=xl9921002 width=97 style='mso-width-source:userset;mso-width-alt:
 3104;width:73pt'>
 <col class=xl9921002 width=134 style='mso-width-source:userset;mso-width-alt:
 4288;width:101pt'>
 <col class=xl10021002 width=214 style='mso-width-source:userset;mso-width-alt:
 6848;width:161pt'>
 <col class=xl9921002 width=94 style='mso-width-source:userset;mso-width-alt:
 3008;width:71pt'>
 <col class=xl9921002 width=73 span=4 style='width:55pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl14321002 width=544 style='height:15.75pt;
  width:409pt'>Công ty TNHH Dorco Vina</td>
  <td class=xl9921002 width=97 style='width:73pt'></td>
  <td class=xl9921002 width=134 style='width:101pt'></td>
  <td class=xl10021002 width=214 style='width:161pt'></td>
  <td class=xl10121002 width=94 style='width:71pt'></td>
  <td class=xl10121002 width=73 style='width:55pt'></td>
  <td class=xl9921002 width=73 style='width:55pt'></td>
  <td class=xl9921002 width=73 style='width:55pt'></td>
  <td class=xl9921002 width=73 style='width:55pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl14921002 style='height:15.75pt'>&#272;&#432;&#7901;ng
  B3, khu B, KCN Ph&#7889; N&#7889;i A</td>
  <td class=xl10521002 >S&#7889;/No: <%=dt.Rows[0]["slip_no"]%></td>
  <td class=xl10521002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl14221002 width=544 style='height:15.75pt;
  width:409pt'>Xã Minh H&#7843;i Huy&#7879;n V&#259;n Lâm, H&#432;ng Yên</td>
  <td class=xl10521002></td>
  <td class=xl10521002></td>
  <td class=xl10021002></td>
  <td class=xl10121002></td>
  <td class=xl10121002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl10221002 width=32 style='height:15.0pt;width:24pt'></td>
  <td class=xl11621002 width=314 style='width:236pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl11721002></td>
  <td class=xl11121002></td>
  <td class=xl11121002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=6 rowspan=2 height=54 class=xl15021002 style='height:40.5pt'>PHI&#7870;U
  CHUY&#7874;N KHO</td>
  <td class=xl10121002></td>
  <td class=xl10121002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl11121002 style='height:20.25pt'></td>
  <td class=xl11121002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=2 height=25 class=xl15121002 style='height:18.75pt'></td>
  <td colspan=2 class=xl15221002><span style='mso-spacerun:yes'>             
  </span>Ngày/ Date: <%=dt.Rows[0]["dd"]%>/<%=dt.Rows[0]["mm"]%>/<%=dt.Rows[0]["yyyy"]%></td>
  <td class=xl14121002></td>
  <td class=xl11421002></td>
  <td class=xl11521002></td>
  <td class=xl11521002></td>
  <td class=xl12221002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:13.15pt'>
  <td height=17 class=xl11321002 style='height:13.15pt'></td>
  <td class=xl11321002></td>
  <td class=xl11221002></td>
  <td class=xl10921002></td>
  <td class=xl10921002></td>
  <td class=xl11021002></td>
  <td class=xl12121002></td>
  <td class=xl12121002></td>
  <td class=xl12021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=3 height=27 class=xl14821002 width=346 style='height:20.45pt;
  width:260pt'>Kho xu&#7845;t: <%=dt.Rows[0]["out_name"]%></td>
  <td class=xl11821002></td>
  <td class=xl11821002></td>
  <td class=xl11821002></td>
  <td class=xl13321002 width=214 style='width:161pt'></td>
  <td class=xl11921002 width=94 style='width:71pt'></td>
  <td class=xl11921002 width=73 style='width:55pt'></td>
  <td class=xl11821002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr class=xl10921002 height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=3 height=27 class=xl14821002 width=346 style='height:20.45pt;
  width:260pt'>Kho nh&#7853;n: <%=dt.Rows[0]["in_name"]%></td>
  <td class=xl12721002 width=198 style='width:149pt'></td>
  <td class=xl11821002></td>
  <td class=xl11821002></td>
  <td class=xl13221002></td>
  <td class=xl10121002></td>
  <td class=xl10121002></td>
  <td class=xl12621002 width=73 style='width:55pt'></td>
  <td class=xl10921002></td>
  <td class=xl10921002></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=2 height=27 class=xl15321002 style='height:20.45pt'>Lý do: <%=dt.Rows[0]["description"]%></td>
  <td class=xl12521002 width=198 style='width:149pt'></td>
  <td class=xl12521002 width=97 style='width:73pt'></td>
  <td class=xl13521002 width=134 style='width:101pt'></td>
  <td class=xl13421002 width=214 style='width:161pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=3 height=96 class=xl14421002 width=32 style='border-bottom:.5pt solid black;
  height:72.0pt;border-top:none;width:24pt'>Stt<br>
    <span style='mso-spacerun:yes'> </span>No</td>
  <td rowspan=3 class=xl14421002 width=314 style='border-bottom:.5pt solid black;
  border-top:none;width:236pt'>Tên v&#7853;t t&#432;<br>
    <font class="font621002">(Material name)</font></td>
  <td rowspan=3 class=xl14721002 width=198 style='width:149pt'>Mã
  s&#7889;<br>
    <font class="font621002">(Code)</font></td>
  <td rowspan=3 class=xl14421002 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>&#272;&#417;n v&#7883; tính<br>
    (<font class="font621002">Q.unit)</font></td>
  <td rowspan=3 class=xl14421002 width=134 style='border-bottom:.5pt solid black;
  width:101pt'>S&#7889; l&#432;&#7907;ng ( Quantity)</td>
  <td rowspan=3 class=xl14421002 width=214 style='border-bottom:.5pt solid black;
  width:161pt'>Ghi chú (Remark)</td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl9921002 style='height:24.0pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl9921002 style='height:24.0pt'></td>
  <td class=xl9921002></td>
  <td class=xl10821002 width=73 style='width:55pt'></td>
  <td class=xl10821002 width=73 style='width:55pt'></td>
  <td class=xl9921002></td>
 </tr>
 <%
     double total1 = 0;
     for(int i =0 ; i<dt1.Rows.Count;i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt1.Rows[i]["tr_qty"]);
       %>
<tr class=xl10621002 height=45 style='mso-height-source:userset;height:34.15pt'>
  <td height=45 class=xl12821002 width=32 style='height:34.15pt;width:24pt'
  x:num><%=i+1%></td>
  <td class=xl13921002 style='border-left:none'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl13721002 style='border-left:none'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl12821002 width=97 style='border-left:none;width:73pt'><%=dt1.Rows[i]["tr_uom"]%></td>
  <td class=xl13621002 style='border-left:none' x:num><%=dt1.Rows[i]["tr_qty"]%></td>
  <td class=xl14021002 style='border-left:none'><%=dt1.Rows[i]["description"]%></td>
  <td class=xl10721002></td>
  <td class=xl10721002></td>
  <td class=xl10621002></td>
  <td class=xl10621002></td>
  <td class=xl10621002></td>
 </tr>
       <%  
     }
      %>
 <tr class=xl10521002 height=42 style='mso-height-source:userset;height:31.9pt'>
  <td height=42 class=xl12921002 width=32 style='height:31.9pt;width:24pt'>&nbsp;</td>
  <td class=xl13021002 width=314 style='border-left:none;width:236pt'>C&#7897;ng/<font
  class="font521002"> Total</font></td>
  <td class=xl12921002 width=198 style='border-left:none;width:149pt'>&nbsp;</td>
  <td class=xl12921002 width=97 style='border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl13021002 width=134 style='border-left:none;width:101pt'x:num><%=total1%></td>
  <td class=xl13121002 width=214 style='border-left:none;width:161pt'>&nbsp;</td>
  <td class=xl10521002></td>
  <td class=xl10521002></td>
  <td class=xl10521002></td>
  <td class=xl10521002></td>
  <td class=xl10521002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl9921002 style='height:15.75pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl12321002 style='height:15.75pt'>Ng&#432;&#7901;i
  l&#7853;p phi&#7871;u</td>
  <td class=xl12321002></td>
  <td class=xl12321002>Th&#7911; kho</td>
  <td class=xl12321002></td>
  <td class=xl12321002>Qu&#7843;n lý kho</td>
  <td class=xl10421002 width=94 style='width:71pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl12321002 style='height:15.75pt'>Prepared by</td>
  <td class=xl12421002></td>
  <td class=xl12421002>Stock keeper</td>
  <td class=xl12321002></td>
  <td class=xl12321002>Warehouse manager</td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl12321002 style='height:15.75pt'>(Ký, h&#7885;
  tên- Signature)</td>
  <td class=xl12321002></td>
  <td class=xl12321002>(Ký, h&#7885; tên- Signature)</td>
  <td class=xl12421002></td>
  <td class=xl12421002><span style='mso-spacerun:yes'>  </span>(Ký, h&#7885;
  tên- Signature)</td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl10221002 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl10221002 width=314 style='width:236pt'></td>
  <td class=xl10221002 width=198 style='width:149pt'></td>
  <td class=xl10221002 width=97 style='width:73pt'></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl10221002 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl10221002 width=314 style='width:236pt'></td>
  <td class=xl10221002 width=198 style='width:149pt'></td>
  <td class=xl10221002 width=97 style='width:73pt'></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl10221002 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl10221002 width=314 style='width:236pt'></td>
  <td class=xl10221002 width=198 style='width:149pt'></td>
  <td class=xl10221002 width=97 style='width:73pt'></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl10321002 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl10221002 width=314 style='width:236pt'></td>
  <td class=xl10221002 width=198 style='width:149pt'></td>
  <td class=xl10221002 width=97 style='width:73pt'></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl9921002 style='height:15.75pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl9921002 style='height:15.75pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl9921002 style='height:15.75pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl9921002 style='height:15.75pt'></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl10021002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
  <td class=xl9921002></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=314 style='width:236pt'></td>
  <td width=198 style='width:149pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=214 style='width:161pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
