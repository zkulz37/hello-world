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
    string master_pk = Request.QueryString["master_pk"];
    DataTable dt1 = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00140_2", "'" + master_pk + "'");
    DataTable dt = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00140_1", "'" + master_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00140_droco_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="111117_Trieu_Copy of Form xuat nhap kho_31-oct(1)_1865_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font51865
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font61865
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font71865
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.font81865
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;}
.xl991865
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
.xl1001865
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
.xl1011865
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
.xl1021865
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
.xl1031865
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
.xl1041865
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
.xl1051865
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
.xl1061865
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
.xl1071865
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
.xl1081865
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
.xl1091865
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
.xl1101865
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
.xl1111865
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
.xl1121865
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
.xl1131865
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
.xl1141865
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
.xl1151865
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
.xl1161865
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
.xl1171865
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
.xl1181865
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
.xl1191865
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
.xl1201865
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
.xl1211865
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
.xl1221865
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
.xl1231865
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
.xl1241865
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
.xl1251865
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
.xl1261865
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
.xl1271865
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
.xl1281865
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
.xl1291865
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
.xl1301865
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
.xl1311865
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
.xl1321865
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
.xl1331865
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
.xl1341865
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
.xl1351865
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
.xl1361865
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
.xl1371865
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
.xl1381865
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1391865
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1401865
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1411865
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl1421865
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
.xl1431865
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
.xl1441865
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
.xl1451865
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
.xl1461865
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
.xl1471865
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
.xl1481865
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
.xl1491865
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
.xl1501865
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
.xl1511865
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
.xl1521865
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
.xl1531865
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
.xl1541865
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
.xl1551865
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
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl1561865
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

<div id="111117_Trieu_Copy of Form xuat nhap kho_31-oct(1)_1865" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1379 class=xl991865
 style='border-collapse:collapse;table-layout:fixed;width:1037pt'>
 <col class=xl991865 width=32 style='mso-width-source:userset;mso-width-alt:
 1024;width:24pt'>
 <col class=xl991865 width=297 style='mso-width-source:userset;mso-width-alt:
 9504;width:223pt'>
 <col class=xl991865 width=210 style='mso-width-source:userset;mso-width-alt:
 6720;width:158pt'>
 <col class=xl991865 width=97 style='mso-width-source:userset;mso-width-alt:
 3104;width:73pt'>
 <col class=xl991865 width=127 style='mso-width-source:userset;mso-width-alt:
 4064;width:95pt'>
 <col class=xl1001865 width=230 style='mso-width-source:userset;mso-width-alt:
 7360;width:173pt'>
 <col class=xl991865 width=94 style='mso-width-source:userset;mso-width-alt:
 3008;width:71pt'>
 <col class=xl991865 width=73 span=4 style='width:55pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1501865 width=539 style='height:15.75pt;
  width:405pt'>Cng ty TNHH Dorco Vina</td>
  <td class=xl991865 width=97 style='width:73pt'></td>
  <td class=xl991865 width=127 style='width:95pt'></td>
  <td class=xl1001865 width=230 style='width:173pt'></td>
  <td class=xl1011865 width=94 style='width:71pt'></td>
  <td class=xl1011865 width=73 style='width:55pt'></td>
  <td class=xl991865 width=73 style='width:55pt'></td>
  <td class=xl991865 width=73 style='width:55pt'></td>
  <td class=xl991865 width=73 style='width:55pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1521865 style='height:15.75pt'>Đường B3, khu B, KCN Phố Nối A</td>
  <td class=xl1051865>S&#7889;/No: <%=dt.Rows[0]["slip_no"] %></td>
  <td class=xl1051865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl1531865 width=539 style='height:15.75pt;
  width:405pt'>Xã Minh Hải Huyện Văn Lâm, Hưng Yên</td>
  <td class=xl1051865></td>
  <td class=xl1051865></td>
  <td class=xl1001865></td>
  <td class=xl1011865></td>
  <td class=xl1011865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl1021865 width=32 style='height:15.0pt;width:24pt'></td>
  <td class=xl1161865 width=297 style='width:223pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1171865></td>
  <td class=xl1111865></td>
  <td class=xl1111865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=6 rowspan=2 height=54 class=xl1451865 style='height:40.5pt'>PHIẾU HỦY HÀNG</td>
  <td class=xl1011865></td>
  <td class=xl1011865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl1111865 style='height:20.25pt'></td>
  <td class=xl1111865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=2 height=25 class=xl1541865 style='height:18.75pt'></td>
  <td colspan=2 class=xl1551865><span style='mso-spacerun:yes'>Ngày/Date: <%=dt.Rows[0]["out_date"]%></td>
  <td class=xl1371865></td>
  <td class=xl1141865></td>
  <td class=xl1151865></td>
  <td class=xl1151865></td>
  <td class=xl1211865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:13.15pt'>
  <td height=17 class=xl1131865 style='height:13.15pt'></td>
  <td class=xl1131865></td>
  <td class=xl1121865></td>
  <td class=xl1091865></td>
  <td class=xl1091865></td>
  <td class=xl1101865></td>
  <td class=xl1201865></td>
  <td class=xl1201865></td>
  <td class=xl1191865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr class=xl1091865 height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=3 height=27 class=xl1491865 width=329 style='height:20.45pt;
  width:247pt'>Hủy tại kho: <%=dt.Rows[0]["wh_name"]%></td>
  <td class=xl1261865 width=210 style='width:158pt'></td>
  <td class=xl1181865></td>
  <td class=xl1181865></td>
  <td class=xl1301865></td>
  <td class=xl1011865></td>
  <td class=xl1011865></td>
  <td class=xl1251865 width=73 style='width:55pt'></td>
  <td class=xl1091865></td>
  <td class=xl1091865></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.45pt'>
  <td colspan=3 height=27 class=xl1561865 style='height:20.45pt'>Lý do: <%=dt.Rows[0]["description"]%></td>
  <td class=xl1241865 width=210 style='width:158pt'></td>
  <td class=xl1241865 width=97 style='width:73pt'></td>
  <td class=xl1321865 width=127 style='width:95pt'></td>
  <td class=xl1311865 width=230 style='width:173pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=3 height=96 class=xl1421865 width=32 style='border-bottom:.5pt solid black;
  height:72.0pt;border-top:none;width:24pt'>Stt<br>
    <span style='mso-spacerun:yes'></span>No</td>
  <td rowspan=3 class=xl1421865 width=297 style='border-bottom:.5pt solid black;
  border-top:none;width:223pt'>Tên vật tư<br>
    <font class="font61865">(Material name)</font></td>
  <td rowspan=3 class=xl1511865 width=210 style='width:158pt'>Mã số<br>
    <font class="font61865">(Code)</font></td>
  <td rowspan=3 class=xl1421865 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Đơn vị tính<br>
    (<font class="font61865">Q.unit)</font></td>
  <td rowspan=3 class=xl1461865 width=127 style='border-bottom:.5pt solid black;
  width:95pt'>Số lượng <br> (Quantity)</td>
  <td rowspan=3 class=xl1421865 width=230 style='border-bottom:.5pt solid black;
  width:173pt'>Ghi chú (Remark)</td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl991865 style='height:24.0pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl991865 style='height:24.0pt'></td>
  <td class=xl991865></td>
  <td class=xl1081865 width=73 style='width:55pt'></td>
  <td class=xl1081865 width=73 style='width:55pt'></td>
  <td class=xl991865></td>
 </tr>
 <%
     double total = 0;
     for (int i = 0; i < dt1.Rows.Count;i++ )
     {
         total = total + CommondLib.ConvertToDbl(dt1.Rows[i]["out_qty"]);
        %>
<tr class=xl1061865 height=45 style='mso-height-source:userset;height:34.15pt'>
  <td height=45 class=xl1271865 width=32 style='height:34.15pt;width:24pt' x:num><%=i+1 %></td>
  <td class=xl1361865 style='border-left:none'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl1341865 style='border-left:none'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl1271865 width=97 style='border-left:none;width:73pt'><%=dt1.Rows[i]["out_uom"]%></td>
  <td class=xl1331865 style='border-left:none' x:num><%=dt1.Rows[i]["out_qty"]%></td>
  <td class=xl1381865 style='border-top:none'><%=dt1.Rows[i]["description"]%></td>
  <td class=xl1071865></td>
  <td class=xl1071865></td>
  <td class=xl1061865></td>
  <td class=xl1061865></td>
  <td class=xl1061865></td>
 </tr>
        <%
     }
  %>
 
 
 <tr class=xl1051865 height=42 style='mso-height-source:userset;height:31.9pt'>
  <td height=42 class=xl1281865 width=32 style='height:31.9pt;width:24pt'>&nbsp;</td>
  <td class=xl1291865 width=297 style='border-left:none;width:223pt'>C&#7897;ng/<font
  class="font51865"> Total</font></td>
  <td class=xl1281865 width=210 style='border-left:none;width:158pt'>&nbsp;</td>
  <td class=xl1281865 width=97 style='border-left:none;width:73pt'>&nbsp;</td>
  <td class=xl1291865 width=127 style='border-left:none;width:95pt'x:num><%=total%></td>
  <td class=xl1411865 width=230 style='border-top:none;width:173pt'>&nbsp;</td>
  <td class=xl1051865></td>
  <td class=xl1051865></td>
  <td class=xl1051865></td>
  <td class=xl1051865></td>
  <td class=xl1051865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl991865 style='height:15.75pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl1221865 style='height:15.75pt'>Ng&#432;&#7901;i
  l&#7853;p phi&#7871;u</td>
  <td class=xl991865></td>
  <td class=xl1221865>Th&#7911; kho</td>
  <td class=xl1221865></td>
  <td class=xl1221865>Qu&#7843;n lý kho</td>
  <td class=xl1041865 width=94 style='width:71pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl1221865 style='height:15.75pt'>Prepared by</td>
  <td class=xl991865></td>
  <td class=xl1231865>Stock keeper</td>
  <td class=xl1231865></td>
  <td class=xl1221865>Warehouse manager</td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl1221865 style='height:15.75pt'>(Kí, h&#7885;
  tên- Signature)</td>
  <td class=xl991865></td>
  <td class=xl1221865>(Kí, h&#7885; tên- Signature)</td>
  <td class=xl1221865></td>
  <td class=xl1231865><span style='mso-spacerun:yes'> </span>(Kí, h&#7885;
  tên- Signature)</td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1021865 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1021865 width=297 style='width:223pt'></td>
  <td class=xl1021865 width=210 style='width:158pt'></td>
  <td class=xl1021865 width=97 style='width:73pt'></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1021865 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1021865 width=297 style='width:223pt'></td>
  <td class=xl1021865 width=210 style='width:158pt'></td>
  <td class=xl1021865 width=97 style='width:73pt'></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1021865 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1021865 width=297 style='width:223pt'></td>
  <td class=xl1021865 width=210 style='width:158pt'></td>
  <td class=xl1021865 width=97 style='width:73pt'></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1031865 width=32 style='height:15.75pt;width:24pt'></td>
  <td class=xl1021865 width=297 style='width:223pt'></td>
  <td class=xl1021865 width=210 style='width:158pt'></td>
  <td class=xl1021865 width=97 style='width:73pt'></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl991865 style='height:15.75pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl991865 style='height:15.75pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl991865 style='height:15.75pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl991865 style='height:15.75pt'></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl1001865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
  <td class=xl991865></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=297 style='width:223pt'></td> 
  <td width=210 style='width:158pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=230 style='width:173pt'></td>
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
