<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
string p_from_dt = Request["from_dt"];
string p_to_dt = Request["to_dt"];
string p_com_pk = Request["company_pk"];
string p_item = Request["item"];
string p_tac_plcenter_pk = Request["tac_abplcenter_pk"];
string SQL = "";
	int i, j;
	string l_tuden_ngay = p_from_dt.Substring(6, 2) + "/" + p_from_dt.Substring(4, 2) + "/" + p_from_dt.Substring(0, 4);
	l_tuden_ngay += " - " + p_to_dt.Substring(6, 2) + "/" + p_to_dt.Substring(4, 2) + "/" + p_to_dt.Substring(0, 4);
	string l_tac_abplcenter_pk = "";
	decimal l_tot_amt_vnd= 0, l_tot_amt_us = 0;
	string l_plcd = "", l_plnm = "";
	decimal l_grand_vnd = 0, l_grand_usd = 0;
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_Out_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00220_Out_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00220_Out_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-28T04:28:01Z</o:Created>
  <o:LastSaved>2010-04-28T04:31:08Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
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
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl24
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:LeftColumnVisible>8</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9555</x:WindowHeight>
  <x:WindowWidth>17145</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl62>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2088 style='border-collapse:
 collapse;table-layout:fixed;width:1569pt'>
 <col class=xl62 width=78 span=3 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <col class=xl62 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl62 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl62 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl62 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl62 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl62 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl62 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl62 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl62 width=64 style='width:48pt'>
 <col class=xl62 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl62 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl62 width=163 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <col class=xl62 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl62 width=64 style='width:48pt'>
 <col class=xl62 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl62 width=64 span=9 style='width:48pt'>
 <tr class=xl24 height=27 style='height:20.25pt'>
  <td height=27 class=xl24 width=78 style='height:20.25pt;width:59pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td colspan=16 class=xl25 width=1356 style='width:1019pt'>LIST OF MATERIAL
  SUPPLY FOR PROJECT</td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 align=left style='height:20.1pt'>PERIOD: <%=l_tuden_ngay%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl29></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'>Voucher No.</td>
  <td class=xl31 style='border-left:none'>Seq</td>
  <td class=xl31 style='border-left:none'>Take out No.</td>
  <td class=xl32>Date</td>
  <td class=xl33>Code</td>
  <td class=xl32>Name of material</td>
  <td class=xl32>Unit</td>
  <td class=xl32>Q'ty</td>
  <td class=xl34 x:str="Weight"><span
  style='mso-spacerun:yes'> </span>Weight<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:str="U.price"><span
  style='mso-spacerun:yes'> </span>U.price<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:str="Amount _ vnd"><span
  style='mso-spacerun:yes'> </span>Amount _ vnd<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="U.price_us"><span
  style='mso-spacerun:yes'> </span>U.price_us<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="Amount _ us"><span
  style='mso-spacerun:yes'> </span>Amount _ us<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none' x:str="Project"><span style='mso-spacerun:yes'> </span>Project<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl38 style='border-left:none'>Employee ID</td>
  <td class=xl31>Cr</td>
  <td class=xl31 style='border-left:none'>Dr</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <%
//	for( i = 0; i < 0 ; i++)
	//{
 SQL
	= "select a.voucher_no, (select h.pk from tac_hgtrh h where " + 
        "  h.tr_date= to_date(a.trans_dt, 'YYYYMMDD') and h.tr_status in ('2', '0') and h.voucher_type = 'XNL' and rownum=1 ) seq " +
        "    , (select b.slip_no from inv.vin_outgoing_project b where b.pk = d.tin_stocktr_pk ) takeout_no " +
        "    , to_char(to_date(a.trans_dt, 'YYYYMMDD'), 'DD/MM/YYYY') tr_date " +
        "    , i.item_code, i.item_name, i.uom, d.qty, 0 weight, 0 uprice, t.out_tramt " +
        "    , round(d.uprice, 5) uprice, t.out_amt, v.pl_cd, v.pl_nm " +
         " , (select b.receiver from inv.vin_outgoing_project b where b.pk = d.tin_stocktr_pk) emp_name " +
        "  , '' emp_id  " +
        "    , (select c.ac_cd from tac_abacctcode c where c.pk = d.credit_acctcode_pk) cr_cd " +
        "    , (select c.ac_cd from tac_abacctcode c where c.pk = d.debit_acctcode_pk) dr_cd " +
        "from tac_omcost_pricerd d, tac_omcost_pricer a, tco_item i, v_abplcenter v " +
        "    , tac_stocktr t " +
        "where a.trans_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "and a.tco_company_pk = '" + p_com_pk + "' " +
        "and a.del_if = 0 " +
        "and a.pk = d.tac_omcost_pricer_pk " +
        "and d.del_if = 0 " +
        "and t.tr_table_nm = 'TAC_OMCOST_PRICERD' " +
        "and d.pk = t.tr_table_pk " +
        "and t.del_if = 0 " +
        "and t.tr_status in ('2', '0') " +
        "and d.tco_item_pk = i.pk " +
        "and i.item_code not like '%-S' " +
        "and d.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
		" and (d.tac_abplcenter_pk like '" + p_tac_plcenter_pk + "' or '" + p_tac_plcenter_pk + "' is null )" +
		" and (i.item_code like '" + p_item + "' or '" + p_item + "' is null )" +
		" order by v.pl_cd, a.voucher_no " ;
        
	DataTable dtDtl = ESysLib.TableReadOpen(SQL);
	if(dtDtl.Rows.Count > 0)
	{
		l_plcd = dtDtl.Rows[0][13].ToString();
		l_plnm = dtDtl.Rows[0][14].ToString();
	}	
	for(j = 0 ; j < dtDtl.Rows.Count; j++)
	{
        if(dtDtl.Rows[j][10].ToString().Trim() != "")
		    l_grand_vnd += decimal.Parse(dtDtl.Rows[j][10].ToString());
        if(dtDtl.Rows[j][12].ToString().Trim() != "")
		    l_grand_usd += decimal.Parse(dtDtl.Rows[j][12].ToString());
 	if(l_plcd != dtDtl.Rows[j][13].ToString())
	{		
 %>
 <tr class=xl63 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55 style='border-top:none'>Subtotal</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl78 x:num><span style='mso-spacerun:yes'>     
  </span><%=l_tot_amt_vnd%> </td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56 align=left x:num><span
  style='mso-spacerun:yes'>         </span><%=l_tot_amt_us%> </td>
  <td class=xl58 align=left x:str><span
  style='mso-spacerun:yes'> </span><%=l_plcd%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl59 align=left style='border-top:none'
  x:str><span
  style='mso-spacerun:yes'> </span><%=l_plnm%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
  <td class=xl61 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=8 class=xl62 style='mso-ignore:colspan'></td>
 </tr>
   <tr class=xl24 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl40 style='height:24.0pt'><%=dtDtl.Rows[j][0]%></td>
  <td class=xl41 style='border-top:none'><%=dtDtl.Rows[j][1]%></td>
  <td class=xl42 align=left style='border-left:none'><%=dtDtl.Rows[j][2]%></td>
  <td class=xl43><%=dtDtl.Rows[j][3]%></td>
  <td class=xl44 align=left><%=dtDtl.Rows[j][4]%></td>
  <td class=xl45 align=left width=181 style='width:136pt'><%=dtDtl.Rows[j][5]%></td>
  <td class=xl43><%=dtDtl.Rows[j][6]%></td>
  <td class=xl75 align=right x:num><%=dtDtl.Rows[j][7]%></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'>         </span> </td>
  <td class=xl77 x:num><span style='mso-spacerun:yes'>          
  </span><%=dtDtl.Rows[j][10]%> </td>
  <td class=xl47 x:num><%=dtDtl.Rows[j][11]%></td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dtDtl.Rows[j][12]%> </td>
  <td class=xl48 align=left x:str><span
  style='mso-spacerun:yes'> </span><%=dtDtl.Rows[j][13]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49><%=dtDtl.Rows[j][14]%></td>
  <td class=xl44 align=left><%=dtDtl.Rows[j][15]%></td>
  <td class=xl50></td>
  <td class=xl45 align=left width=92 style='width:69pt'><%=dtDtl.Rows[j][17]%></td>
  <td class=xl45 align=left width=64 style='width:48pt'><%=dtDtl.Rows[j][18]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
        if(dtDtl.Rows[j][10].ToString().Trim() != "")
			 l_tot_amt_vnd = decimal.Parse(dtDtl.Rows[j][10].ToString());
        if(dtDtl.Rows[j][12].ToString().Trim() != "")        
			l_tot_amt_us = decimal.Parse(dtDtl.Rows[j][12].ToString());
			l_plcd = dtDtl.Rows[j][13].ToString();
			l_plnm = dtDtl.Rows[j][14].ToString();			
		}
		else
		{
 %>
  <tr class=xl24 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl40 style='height:24.0pt'><%=dtDtl.Rows[j][0]%></td>
  <td class=xl41 style='border-top:none'><%=dtDtl.Rows[j][1]%></td>
  <td class=xl42 align=left style='border-left:none'><%=dtDtl.Rows[j][2]%></td>
  <td class=xl43><%=dtDtl.Rows[j][3]%></td>
  <td class=xl44 align=left><%=dtDtl.Rows[j][4]%></td>
  <td class=xl45 align=left width=181 style='width:136pt'><%=dtDtl.Rows[j][5]%></td>
  <td class=xl43><%=dtDtl.Rows[j][6]%></td>
  <td class=xl75 align=right x:num><%=dtDtl.Rows[j][7]%></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'>         </span> </td>
  <td class=xl77 x:num><span style='mso-spacerun:yes'>          
  </span><%=dtDtl.Rows[j][10]%> </td>
  <td class=xl47 x:num><%=dtDtl.Rows[j][11]%></td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'>               </span><%=dtDtl.Rows[j][12]%> </td>
  <td class=xl48 align=left x:str><span
  style='mso-spacerun:yes'> </span><%=dtDtl.Rows[j][13]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49><%=dtDtl.Rows[j][14]%></td>
  <td class=xl44 align=left><%=dtDtl.Rows[j][15]%></td>
  <td class=xl50></td>
  <td class=xl45 align=left width=92 style='width:69pt'><%=dtDtl.Rows[j][17]%></td>
  <td class=xl45 align=left width=64 style='width:48pt'><%=dtDtl.Rows[j][18]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<%	
        if(dtDtl.Rows[j][10].ToString().Trim() != "")
			l_tot_amt_vnd += decimal.Parse(dtDtl.Rows[j][10].ToString());
        if(dtDtl.Rows[j][12].ToString().Trim() != "")
			l_tot_amt_us += decimal.Parse(dtDtl.Rows[j][12].ToString());
		}
	}
%>
<tr class=xl63 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55 style='border-top:none'>Subtotal</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl78 x:num><span style='mso-spacerun:yes'>     
  </span><%=l_tot_amt_vnd%> </td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56 align=left x:num><span
  style='mso-spacerun:yes'>         </span><%=l_tot_amt_us%> </td>
  <td class=xl58 align=left x:str><span
  style='mso-spacerun:yes'> </span><%=l_plcd%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl59 align=left style='border-top:none'
  x:str><span
  style='mso-spacerun:yes'> </span><%=l_plnm%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
  <td class=xl61 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=8 class=xl62 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl74 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl67 style='height:20.1pt'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 align=left>Grand Total</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl79 x:num><span style='mso-spacerun:yes'>  
  </span><%=l_grand_vnd%> </td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71 align=left x:num><span
  style='mso-spacerun:yes'>      </span><%=l_grand_usd%> </td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl70 style='border-top:none'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td colspan=8 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
