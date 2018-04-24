<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["p_master_pk"];
    DataTable dt1 = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00040_1", "'" + master_pk + "'");
    DataTable dt = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00040", "'" + master_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00040_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="111117_Trieu_Copy of Form xuat nhap kho_31-oct(2)_3525_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font53525
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font63525
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font73525
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.font83525
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.xl993525
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
.xl1003525
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
.xl1013525
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
.xl1023525
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
.xl1033525
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
.xl1043525
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
.xl1053525
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
.xl1063525
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
.xl1073525
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
.xl1083525
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
.xl1093525
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
.xl1103525
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
.xl1113525
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
.xl1123525
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
.xl1133525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
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
.xl1143525
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
.xl1153525
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
.xl1163525
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
.xl1173525
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
.xl1183525
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
.xl1193525
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
.xl1203525
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
.xl1213525
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
.xl1223525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
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
.xl1233525
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
.xl1243525
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
.xl1253525
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
.xl1263525
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl1273525
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
.xl1283525
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
.xl1293525
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
.xl1303525
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
.xl1313525
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
.xl1323525
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
.xl1333525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1343525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1353525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1363525
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1373525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1383525
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
.xl1393525
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
.xl1403525
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
.xl1413525
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
.xl1423525
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
.xl1433525
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
.xl1443525
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
.xl1453525
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
.xl1463525
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
	white-space:normal;}
.xl1473525
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
.xl1483525
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
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl1493525
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
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl1503525
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl1513525
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
.xl1523525
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

<div id="111117_Trieu_Copy of Form xuat nhap kho_31-oct(2)_3525" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1670 class=xl993525
 style='border-collapse:collapse;table-layout:fixed;width:1253pt'>
 <col class=xl993525 width=32 style='mso-width-source:userset;mso-width-alt:
 1024;width:24pt'>
 <col class=xl993525 width=239 style='mso-width-source:userset;mso-width-alt:
 7648;width:179pt'>
 <col class=xl993525 width=197 style='mso-width-source:userset;mso-width-alt:
 6304;width:148pt'>
 <col class=xl993525 width=103 style='mso-width-source:userset;mso-width-alt:
 3296;width:77pt'>
 <col class=xl993525 width=163 style='mso-width-source:userset;mso-width-alt:
 5216;width:122pt'>
 <col class=xl993525 width=254 style='mso-width-source:userset;mso-width-alt:
 8128;width:191pt'>
 <col class=xl1003525 width=197 style='mso-width-source:userset;mso-width-alt:
 6304;width:148pt'>
 <col class=xl993525 width=103 style='mso-width-source:userset;mso-width-alt:
 3296;width:77pt'>
 <col class=xl993525 width=163 style='mso-width-source:userset;mso-width-alt:
 5216;width:122pt'>
 <col class=xl993525 width=73 style='width:55pt'>
 <col class=xl993525 width=73 span=2 style='width:55pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1403525 width=468 style='height:15.75pt;
  width:351pt'>Công ty TNHH Dorco Vina</td>
  <td class=xl993525 width=103 style='width:77pt'></td>
  <td class=xl993525 width=163 style='width:122pt'></td>
  <td class=xl993525 width=254 style='width:191pt'></td>
  <td class=xl993525 width=197 style='width:148pt'></td>
  <td class=xl993525 width=103 style='width:77pt'></td>
  <td class=xl1013525 width=163 style='width:122pt'></td>
  <td class=xl993525 width=73 style='width:55pt'></td>
  <td class=xl993525 width=73 style='width:55pt'></td>
  <td class=xl993525 width=73 style='width:55pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1453525 style='height:15.75pt'>&#272;&#432;&#7901;ng
  B3, khu B, KCN Ph&#7889; N&#7889;i A</td>
  <td class=xl1053525></td>
  <td class=xl1053525 >S&#7889;/No: <%=dt.Rows[0]["slip_no"] %><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1383525 width=468 style='height:15.75pt;
  width:351pt'>Xã Minh H&#7843;i Huy&#7879;n V&#259;n Lâm, H&#432;ng Yên</td>
  <td class=xl1053525></td>
  <td class=xl1053525></td>
  <td class=xl1133525></td>
  <td class=xl1133525></td>
  <td class=xl1133525></td>
  <td class=xl1013525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl1023525 width=32 style='height:15.0pt;width:24pt'></td>
  <td class=xl1123525 width=239 style='width:179pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1093525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl1123525 width=32 style='height:20.25pt;width:24pt'></td>
  <td class=xl1123525 width=239 style='width:179pt'></td>
  <td colspan=5 rowspan=2 class=xl1473525>PHI&#7870;U CHUY&#7874;N MÃ HÀNG</td>
  <td class=xl1223525></td>
  <td class=xl1013525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl1193525 width=271 style='height:20.25pt;
  width:203pt'></td>
  <td class=xl1093525></td>
  <td class=xl1093525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=2 height=25 class=xl1513525 style='height:18.75pt'></td>
  <td class=xl1153525 ><span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl1153525></td>
  <td colspan=2 class=xl1393525><span style='mso-spacerun:yes'> </span>Ngày/
  Date: <%=dt.Rows[0]["ex_date"] %></td>
  <td class=xl1103525></td>
  <td class=xl1113525></td>
  <td class=xl1113525></td>
  <td class=xl1153525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr class=xl1083525 height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=4 height=27 class=xl1463525 width=271 style='height:20.45pt;
  width:203pt'>H&#7911;y t&#7841;i kho: <%=dt.Rows[0]["wh_name"] %></td>
  <td class=xl1203525 width=197 style='width:148pt'></td>
  <td class=xl1143525></td>
  <td class=xl1143525></td>
  <td class=xl1143525></td>
  <td class=xl1273525></td>
  <td class=xl1013525></td>
  <td class=xl1013525></td>
  <td class=xl1193525 width=73 style='width:55pt'></td>
  <td class=xl1083525></td>
  <td class=xl1083525></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=2 height=27 class=xl1523525 style='height:20.45pt'>Lý do: <%=dt.Rows[0]["description"] %></td>
  <td class=xl1183525 width=197 style='width:148pt'></td>
  <td class=xl1183525 width=103 style='width:77pt'></td>
  <td class=xl1293525 width=163 style='width:122pt'></td>
  <td class=xl1183525 width=254 style='width:191pt'></td>
  <td class=xl1283525 width=197 style='width:148pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=3 height=96 class=xl1413525 width=32 style='border-bottom:.5pt solid black;
  height:72.0pt;border-top:none;width:24pt'>Stt<br>
    <span style='mso-spacerun:yes'> </span>No</td>
  <td rowspan=3 class=xl1413525 width=239 style='border-bottom:.5pt solid black;
  border-top:none;width:179pt'>Tên v&#7853;t t&#432; yêu c&#7847;u<br>
    <font class="font63525">(Request material name)</font></td>
  <td rowspan=3 class=xl1443525 width=197 style='width:148pt'>Mã s&#7889;<br>
    <font class="font63525">(Request Code)</font></td>
  <td rowspan=3 class=xl1413525 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>&#272;&#417;n v&#7883; tính<br>
    (<font class="font63525">Q.unit)</font></td>
  <td rowspan=3 class=xl1483525 width=163 style='border-bottom:.5pt solid black;
  width:122pt'>S&#7889; l&#432;&#7907;ng yêu c&#7847;u <br>(Request Quantity)</td>
  <td rowspan=3 class=xl1413525 width=254 style='border-bottom:.5pt solid black;
  width:191pt'>Tên v&#7853;t t&#432; &#273;&#432;&#7907;c chuy&#7875;n<br>
    <font class="font63525">(Transfer material name)</font></td>
  <td rowspan=3 class=xl1443525 width=197 style='width:148pt'>Mã s&#7889;<br>
    <font class="font63525">(Transfer Code)</font></td>
  <td rowspan=3 class=xl1413525 width=103 style='border-bottom:.5pt solid black;
  width:77pt'>&#272;&#417;n v&#7883; tính<br>
    (<font class="font63525">Q.unit)</font></td>
  <td rowspan=3 class=xl1413525 width=163 style='border-bottom:.5pt solid black;
  width:122pt'>S&#7889; l&#432;&#7907;ng chuy&#7875;n <br>(Transfer Quantity)</td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl993525 style='height:24.0pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl1073525 width=73 style='height:24.0pt;width:55pt'></td>
  <td class=xl1073525 width=73 style='width:55pt'></td>
  <td class=xl993525></td>
 </tr>
 <%
     double total1 = 0, total2 = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt1.Rows[i]["out_qty"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt1.Rows[i]["ex_qty"]);
         %>
<tr class=xl1063525 height=45 style='mso-height-source:userset;height:34.15pt'>
  <td height=45 class=xl1213525 width=32 style='height:34.15pt;width:24pt' x:num><%=i+1 %></td>
  <td class=xl1313525 style='border-left:none'><%=dt1.Rows[i]["item_name"] %></td>
  <td class=xl1333525 style='border-left:none' x:num><%=dt1.Rows[i]["item_code"] %></td>
  <td class=xl1213525 width=103 style='border-left:none;width:77pt'><%=dt1.Rows[i]["out_uom"] %></td>
  <td class=xl1303525 style='border-left:none' x:num><%=dt1.Rows[i]["out_qty"] %></td>
  <td class=xl1373525 style='border-left:none' ><%=dt1.Rows[i]["ex_item_name"]%></td>
  <td class=xl1353525 style='border-left:none' x:num><%=dt1.Rows[i]["ex_item_code"]%></td>
  <td class=xl1363525 style='border-left:none' ><%=dt1.Rows[i]["ex_uom"]%></td>
  <td class=xl1303525 style='border-left:none' x:num><%=dt1.Rows[i]["ex_qty"]%></td>
  <td class=xl1063525></td>
  <td class=xl1063525></td>
  <td class=xl1063525></td>
 </tr>
         <% 
     }
  %>
 
 
 <tr class=xl1053525 height=42 style='mso-height-source:userset;height:31.9pt'>
  <td height=42 class=xl1233525 width=32 style='height:31.9pt;width:24pt'>&nbsp;</td>
  <td class=xl1243525 width=239 style='border-left:none;width:179pt'>C&#7897;ng/<font
  class="font53525"> Total</font></td>
  <td class=xl1233525 width=197 style='border-left:none;width:148pt'>&nbsp;</td>
  <td class=xl1233525 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl1243525 width=163 style='border-left:none;width:122pt'x:num><%=total1 %></td>
  <td class=xl1253525 width=254 style='border-left:none;width:191pt'>&nbsp;</td>
  <td class=xl1263525 width=197 style='border-left:none;width:148pt'>&nbsp;</td>
  <td class=xl1263525 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl1263525 width=163 style='border-left:none;width:122pt'x:num><%=total2 %></td>
  <td class=xl1053525></td>
  <td class=xl1053525></td>
  <td class=xl1053525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl993525 style='height:15.75pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl1163525 style='height:15.75pt'>Ng&#432;&#7901;i
  l&#7853;p phi&#7871;u</td>
  <td class=xl993525></td>
  <td class=xl1163525></td>
  <td class=xl1163525>Th&#7911; kho</td>
  <td class=xl1043525 width=254 style='width:191pt'></td>
  <td class=xl1163525></td>
  <td class=xl1163525>Qu&#7843;n lý kho</td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl1163525 style='height:15.75pt'>Prepared by</td>
  <td class=xl993525></td>
  <td class=xl1173525></td>
  <td class=xl1173525>Stock keeper</td>
  <td class=xl1003525></td>
  <td class=xl1163525></td>
  <td class=xl1163525>Warehouse manager</td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl1163525 style='height:15.75pt'>(Ký, h&#7885;
  tên- Signature)</td>
  <td class=xl993525></td>
  <td class=xl1163525></td>
  <td class=xl1163525>(Ký, h&#7885; tên- Signature)</td>
  <td class=xl993525></td>
  <td class=xl1173525></td>
  <td class=xl1173525><span style='mso-spacerun:yes'>  </span>(Ký, h&#7885;
  tên- Signature)</td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1023525 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1023525 width=239 style='width:179pt'></td>
  <td class=xl1023525 width=197 style='width:148pt'></td>
  <td class=xl1023525 width=103 style='width:77pt'></td>
  <td class=xl1023525 width=163 style='width:122pt'></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1023525 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1023525 width=239 style='width:179pt'></td>
  <td class=xl1023525 width=197 style='width:148pt'></td>
  <td class=xl1023525 width=103 style='width:77pt'></td>
  <td class=xl1023525 width=163 style='width:122pt'></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1023525 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1023525 width=239 style='width:179pt'></td>
  <td class=xl1023525 width=197 style='width:148pt'></td>
  <td class=xl1023525 width=103 style='width:77pt'></td>
  <td class=xl1023525 width=163 style='width:122pt'></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1033525 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1023525 width=239 style='width:179pt'></td>
  <td class=xl1023525 width=197 style='width:148pt'></td>
  <td class=xl1023525 width=103 style='width:77pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl993525 style='height:15.75pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl993525 style='height:15.75pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl993525 style='height:15.75pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl993525 style='height:15.75pt'></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl1003525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
  <td class=xl993525></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=239 style='width:179pt'></td>
  <td width=197 style='width:148pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=254 style='width:191pt'></td>
  <td width=197 style='width:148pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=163 style='width:122pt'></td>
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
