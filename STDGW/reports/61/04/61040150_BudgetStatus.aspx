<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string P_Project_Pk = Request["Project_Pk"];
    string P_Budget_Pk = Request["Budget_Pk"];
    string P_Report_Type = Request["Report_Type"];
    string p_Project_Cd = Request["Project_Cd"];
    string p_Project_Nm = Request["Project_Nm"];
    string p_Budget_Cd = Request["Budget_Cd"];
    string l_parameter = "'" + P_Project_Pk + "','" + P_Budget_Pk + "','" + P_Report_Type + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_2115_BUDGETSATUS", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	 string l_parameter1 = "'" + P_Project_Pk + "','" + P_Budget_Pk + "'" ;
	DataTable dtSum = ESysLib.TableReadOpenCursor("sp_rpt_kpbm2115_date", l_parameter1);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbm2115_BudgetStatus_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbm2115_BudgetStatus_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbm2115_BudgetStatus_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-07-05T08:58:35Z</o:LastPrinted>
  <o:Created>2011-06-11T02:11:00Z</o:Created>
  <o:LastSaved>2011-08-13T03:30:28Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .33in .5in .49in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2";}
.style22
	{mso-number-format:0%;
	mso-style-name:"Percent 2";}
.style23
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"\C27C\D45C \[0\] 3";}
.style24
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
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"\D45C\C900_monthly project profit\(jun\)-rolling";}
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
.xl28
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style21;
	color:windowtext;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style21;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style21;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style21;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style21;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style24;
	color:windowtext;
	font-size:8.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#003300;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style24;
	color:windowtext;
	font-size:10.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#003300;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style24;
	color:windowtext;
	font-size:10.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	background:#003300;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style21;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style21;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style23;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style21;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style21;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style21;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style21;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl74
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Budget status</x:Name>
    <x:WorksheetOptions>
     <x:StandardWidth>2304</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>75</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>29</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12120</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Budget status'!$1:$19</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=17330 style='border-collapse:
 collapse;table-layout:fixed;width:12999pt'>
 <col class=xl28 width=31 style='mso-width-source:userset;mso-width-alt:992;
 width:23pt'>
 <col class=xl28 width=13 span=2 style='mso-width-source:userset;mso-width-alt:
 416;width:10pt'>
 <col class=xl28 width=246 style='mso-width-source:userset;mso-width-alt:7872;
 width:185pt'>
 <col class=xl28 width=71 style='mso-width-source:userset;mso-width-alt:2272;
 width:53pt'>
 <col class=xl28 width=78 style='mso-width-source:userset;mso-width-alt:2496;
 width:59pt'>
 <col class=xl28 width=254 style='mso-width-source:userset;mso-width-alt:8128;
 width:191pt'>
 <col class=xl28 width=69 style='mso-width-source:userset;mso-width-alt:2208;
 width:52pt'>
 <col class=xl28 width=195 style='mso-width-source:userset;mso-width-alt:6240;
 width:146pt'>
 <col class=xl28 width=72 style='mso-width-source:userset;mso-width-alt:2304;
 width:54pt'>
 <col class=xl28 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4000'>
 <col class=xl28 width=251 style='mso-width-source:userset;mso-width-alt:8032;
 width:188pt'>
 <col class=xl28 width=125 style='mso-width-source:userset;mso-width-alt:4000;
 width:94pt'>
 <col class=xl29 width=72 span=221 style='width:54pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=31 style='height:12.75pt;width:23pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:0;margin-top:0;
   width:147pt;height:35.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="kpbm2115_BudgetStatus_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:196px;
  height:47px'><img width=196 height=47
  src="kpbm2115_BudgetStatus_files/image002.jpg" alt=newlogo.JPG v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl28 width=31 style='height:12.75pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl28 width=13 style='width:10pt'></td>
  <td class=xl28 width=13 style='width:10pt'></td>
  <td class=xl28 width=246 style='width:185pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl28 width=78 style='width:59pt'></td>
  <td class=xl28 width=254 style='width:191pt'></td>
  <td class=xl28 width=69 style='width:52pt'></td>
  <td class=xl28 width=195 style='width:146pt'></td>
  <td class=xl28 width=72 style='width:54pt'></td>
  <td class=xl28 width=0></td>
  <td class=xl28 width=251 style='width:188pt'></td>
  <td class=xl28 width=125 style='width:94pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl28 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='height:27.75pt'>
  <td colspan=13 height=37 class=xl67 style='border-right:2.0pt double black;
  height:27.75pt'>WORKING BUDGET STATUS</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl30 style='height:25.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl33 colspan=4 style='height:18.0pt;mso-ignore:colspan'>PROJECT CODE :<%=p_Project_Cd %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl33 colspan=4 style='height:18.0pt;mso-ignore:colspan'>PROJECT
  NAME :<%=p_Project_Nm %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl33 style='height:9.0pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl38>+</td>
  <td class=xl28></td>
  <td class=xl28>CLIENT NAME :</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl33 style='height:4.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl28>REASON TO REVISE :</td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl33 style='height:4.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl42 colspan=2 style='mso-ignore:colspan'>HOW WE CAN KEEP PROFIT
  RATE :</td>
  <td colspan=7 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl33 style='height:5.25pt'>&nbsp;</td>
  <td class=xl32></td>
  <td colspan=10 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43 x:str="Provision for retention  :  ">Provision for
  retention<span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'></span></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43>Export proj.</td>
  <td class=xl46></td>
  <td colspan=2 rowspan=2 class=xl59></td>
  <td class=xl43></td>
  <td class=xl43></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43>( See the regulation )</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl43>Others</td>
  <td class=xl46></td>
  <td class=xl43></td>
  <td class=xl43></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl48 style='height:7.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 rowspan=2 height=84 class=xl70 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:63.0pt;border-right:border-bottom:.5pt solid black'>CONTENTS</td>
  <td colspan=2 class=xl73 width=323 style='border-right:.5pt solid black;
  border-left:none;width:243pt'>ORIGINAL (<%=dtSum.Rows[0]["origin"].ToString() %>)</td>
  <td colspan=2 class=xl73 width=267 style='border-right:.5pt solid black;
  border-left:none;width:200pt'>As - is (<%=dtSum.Rows[0]["asis"].ToString() %>)</td>
  <td class=xl43></td>
  <td colspan=2 class=xl75 width=376 style='border-right:2.0pt double black;
  width:282pt'>FINAL (<%=dtSum.Rows[0]["final_"].ToString() %>)</td>
  <td colspan=216 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl49 style='height:33.0pt;border-left:none'
  x:str="AMOUNT ">AMOUNT<span style='mso-spacerun:yes'></span></td>
  <td class=xl50>%</td>
  <td class=xl51 x:str="AMOUNT ">AMOUNT<span style='mso-spacerun:yes'></span></td>
  <td class=xl50>%</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 width=251 style='width:188pt' x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'></span></td>
  <td class=xl54 width=125 style='width:94pt'>%</td>
  <td colspan=216 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <%
      string _space="";

	   string strBegin="";
	      string strEnd="";
          string _color = "";
     
	for(int i = 1; i < dt.Rows.Count; i++)
	{
		 _space="";
		   strBegin="";
	       strEnd="";

	    if(dt.Rows[i]["FONT_STYLE"].ToString()=="B")
		 {
			strBegin="<b>";
			strEnd="</b>";
		 }
        _color = dt.Rows[i][11].ToString();
	     switch(dt.Rows[i][8].ToString())
		   {
			 case "2":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "3":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "4":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "5":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "6":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "7":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "8":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "9":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "10":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
           }
 %>
 <tr class=xl43 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=6 height=26 class=xl83 style='border-right:.5pt solid black;height:20.1pt;background:<%=_color%>' x:str><%=strBegin%><%=_space%><%=dt.Rows[i][0]%><%=strEnd%></td>
  <td class=xl55 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][1]%><%=strEnd%></td>
  <td class=xl57 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][2]%><%=strEnd%></td>
  <td class=xl55 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][3]%> <%=strEnd%></td>
  <td class=xl57 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][4]%><%=strEnd%></td>
  <td></td>
  <td class=xl55 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][5]%><%=strEnd%></td>
  <td class=xl56 style="background:<%=_color%>" x:num><%=strBegin%><%=dt.Rows[i][6]%><%=strEnd%></td>
  <td colspan=216 style="background:<%=_color%>" class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=5 style="background:<%=_color%>" class=xl43 style='mso-ignore:colspan'></td>
 </tr>
<%
	}		
%>
 <tr class=xl43 height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=0 style='display:none'>
  <td class=xl44>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=0 style='display:none'>
  <td class=xl44>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=0 style='display:none'>
  <td class=xl44>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=0 style='display:none'>
  <td class=xl44>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl59>Prepared by</td>
  <td class=xl59></td>
  <td class=xl43></td>
  <td colspan=2 class=xl59>Checked by</td>
  <td colspan=2 class=xl59>Reviewed by</td>
  <td class=xl43></td>
  <td colspan=2 class=xl59 style='border-right:2.0pt double black'>Approval by</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl59>PM ENGINNEER</td>
  <td class=xl59></td>
  <td class=xl43></td>
  <td colspan=2 class=xl59>TEAM LEADER</td>
  <td colspan=2 class=xl59>GROUP LEADER</td>
  <td class=xl43></td>
  <td colspan=2 class=xl78 style='border-right:2.0pt double black'>GENERAL
  DIRECTOR</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=11 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=10 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='border-right:2.0pt double black'></td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td class=xl59></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
  <td class=xl61>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=6 height=22 class=xl82 style='height:16.5pt'>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl46></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl59></td>
  <td class=xl62>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl63 style='height:16.5pt'>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=221 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl28 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=246 style='width:185pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=254 style='width:191pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=0></td>
  <td width=251 style='width:188pt'></td>
  <td width=125 style='width:94pt'></td>
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
