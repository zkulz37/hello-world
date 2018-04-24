<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_pk = Request.QueryString["p_pk"];
	String l_print_date="";
    string l_parameter = "'" + l_pk + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrm00030_allocate_rpt",l_parameter);
    if (dt.Rows.Count == 0)
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
<link rel=File-List href="htrm00030_files/filelist.xml">
<link rel=Edit-Time-Data href="htrm00030_files/editdata.mso">
<link rel=OLE-Object-Data href="htrm00030_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2010-12-15T13:55:18Z</o:LastPrinted>
  <o:Created>2010-12-06T07:07:55Z</o:Created>
  <o:LastSaved>2010-12-15T13:57:53Z</o:LastSaved>
  <o:Company>HP Compaq</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.9in .2in .75in .28in;
	mso-header-margin:.68in;
	mso-footer-margin:.3in;}
.font5
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.xl24
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl83
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl84
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>htrm00030</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=648 style='border-collapse:
 collapse;table-layout:fixed;width:487pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 <col class=xl24 width=157 style='mso-width-source:userset;mso-width-alt:5741;
 width:118pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 width=32 style='height:13.5pt;width:24pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=100 style='width:75pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=91 style='width:68pt'></td>
  <td class=xl24 width=112 style='width:84pt'></td>
  <td class=xl24 width=157 style='width:118pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:36.75pt;margin-top:.75pt;width:99.75pt;
   height:63.75pt;z-index:1'>
   <v:imagedata src="htrm00030_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:49px;margin-top:1px;width:133px;
  height:85px'><img width=133 height=85 src="htrm00030_files/image002.jpg"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl26 width=66 style='height:12.75pt;width:50pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl24 style='height:24.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl90>Registration Form</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl93 style='border-top:none'>Account Number</td>
  <td colspan=2 class=xl91 style='border-right:.5pt solid black;border-left:
  none'>Arrival Date</td>
  <td class=xl33>Departure Date</td>
  <td class=xl33>Arrival Time</td>
  <td class=xl33>Room Type</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl34><%=dt.Rows[0][23]%></td>
  <td colspan=2 class=xl67 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[0][26]%></td>
  <td class=xl35><%=dt.Rows[0][27]%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35><%=dt.Rows[0][25]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl31>Room Rate</td>
  <td colspan=2 class=xl91 style='border-right:.5pt solid black;border-left:
  none'>No Of Guest</td>
  <td colspan=2 class=xl83 style='border-right:.5pt solid black;border-left:
  none'>Advance Deposit</td>
  <td class=xl36>Room No</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl34 x:num><%=dt.Rows[0][10]%></td>
  <td class=xl35 x:num><%=dt.Rows[0][33]%></td>
  <td class=xl35 x:num><%=dt.Rows[0][34]%></td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[0][11]%></td>
  <td class=xl35 x:num><%=dt.Rows[0][3]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl37 align=left>Mr/Mrs/Miss:</td>
  <td colspan=5 class=xl86 style='border-right:.5pt solid black'><%=dt.Rows[0][32]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl88>Surname:<font class="font5"> <%=dt.Rows[0][13]%></font></td>
  <td colspan=2 class=xl89>First Name:<font class="font5"> <%=dt.Rows[0][14]%></font></td>
  <td class=xl39 align=left>Initial:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl24 style='height:31.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=6 class=xl78 style='border-right:.5pt solid black'>Address:<font class="font5"> <%=dt.Rows[0][28]%></font></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl24 style='height:30.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl78>City:<font class="font5"> </font></td>
  <td class=xl40 align=left>Zip Code:</td>
  <td colspan=2 class=xl64 style='border-right:.5pt solid black'>Country:<font
  class="font5"> <%=dt.Rows[0][16]%></font></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl76 style='border-right:.5pt solid black'>Name Of
  Company:</td>
  <td colspan=2 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Occupation:</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl71 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl76 style='border-right:.5pt solid black'>Nationality:</td>
  <td class=xl32 colspan=2 align=left style='mso-ignore:colspan;border-right:
  .5pt solid black'>Passport No: <font class="font5"> <%=dt.Rows[0][35]%></font></td>
  <td class=xl42 align=left>Date/Place of issue</td>
  <td class=xl43>Date of Birth</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl71 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl40 colspan=2 align=left style='mso-ignore:colspan;border-right:
  .5pt solid black'>Expire Date:</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 style='height:30.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl44 colspan=3 align=left style='mso-ignore:colspan'>Name Of
  Guest's Accompanying :</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl24 style='height:21.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl37 align=left>Payment by</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl46>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl49 align=left>o<font class="font7">Cash</font></td>
  <td colspan=2 class=xl62>o<font class="font7">T/A</font></td>
  <td class=xl50 align=left>o<font class="font7">Co.</font></td>
  <td class=xl50 align=left>o<font class="font7">Credit C</font><span
  style='display:none'><font class="font7">ard</font></span></td>
  <td class=xl51>o<font class="font7">Others</font></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 style='height:27.75pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl63 style='border-right:.5pt solid black'>Remarks</td>
  <td colspan=2 class=xl66 style='border-right:.5pt solid black;border-left:
  none'>Receptionist's Initial</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=68 style='mso-height-source:userset;height:51.0pt'>
  <td height=68 class=xl24 style='height:51.0pt'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=4 class=xl67 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=146 style='mso-height-source:userset;height:109.5pt'>
  <td height=146 class=xl24 style='height:109.5pt'></td>
  <td class=xl52>&nbsp;</td>
  <td colspan=3 class=xl56 style='border-right:.5pt solid black'>Guest's
  Signature</td>
  <td colspan=3 class=xl59 width=360 style='border-right:.5pt solid black;
  border-left:none;width:270pt'>I hereby agree to be joinly and severely liable
  <br>
    with the person, company or association as <br>
    may be indicated on this registration card for<br>
    all charges incurred on all accounts as I may<br>
    now or hereafter maintain with the Hotel Service <br>
    . I authorize the service Residence<br>
    to change to my credit card if I choose not<br>
    to check out with the Receptionist.</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td class=xl55></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=157 style='width:118pt'></td>
  <td width=24 style='width:18pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>