<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%

    string p_date = Request.QueryString["ReportDate"], p_date_n="";
    double input_qty = 0, cum_input_qty=0;
    DataTable dt, dt1;
    string sql;

    sql = "select to_char(to_date('" + p_date + "','yyyymmdd'),'Mon dd.yyyy') from dual";

    dt1 = ESysLib.TableReadOpen(sql);
    if (dt1.Rows.Count > 0)
        p_date_n = dt1.Rows[0][0].ToString();
    
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_1","'" + p_date + "'");
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpep00063_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpep00063_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpep00063_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-07-09T03:05:56Z</o:LastPrinted>
  <o:Created>2009-06-29T09:40:36Z</o:Created>
  <o:LastSaved>2009-07-09T03:07:46Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.39in 0in .39in .44in;
	mso-header-margin:.39in;
	mso-footer-margin:.39in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style18
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style16
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	font-family:Arial, sans-serif;
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
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl82
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style18;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>80</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>37</x:Row>
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl79>

<table x:str border=0 cellpadding=0 cellspacing=0 width=995 style='border-collapse:
 collapse;table-layout:fixed;width:749pt'>
 <col class=xl79 width=168 style='mso-width-source:userset;mso-width-alt:6144;
 width:126pt'>
 <col class=xl79 width=102 span=3 style='mso-width-source:userset;mso-width-alt:
 3730;width:77pt'>
 <col class=xl79 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl79 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl79 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl79 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl79 width=11 style='mso-width-source:userset;mso-width-alt:402;
 width:8pt'>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 colspan=3 width=372 style='height:18.0pt;mso-ignore:
  colspan;width:280pt'>DAILY PRODUCTION REPORT</td>
  <td class=xl25 width=102 style='width:77pt'></td>
  <td class=xl25 width=125 style='width:94pt'></td>
  <td class=xl25 width=88 style='width:66pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=88 style='width:66pt'></td>
 </tr>
 <tr class=xl107 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl107 width=168 style='height:19.5pt;width:126pt'>Date:
  <%=p_date_n %></td>
  <td colspan=8 class=xl107 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td rowspan=2 height=39 class=xl112 style='border-bottom:2.0pt double black;
  height:29.25pt'>MILL ROLL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black'>Shift A</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black'>Shift B</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black'>Shift C</td>
  <td class=xl26>TOTAL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black'>%</td>
  <td class=xl26>CUM.</td>
  <td class=xl26>CUM.</td>
  <td rowspan=2 class=xl110 style='border-bottom:2.0pt double black'>%</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>(A+B+C)</td>
  <td class=xl27>Previous</td>
  <td class=xl27>Current</td>
 </tr>
 <% 
     for (int i = 0; i < dt.Rows.Count; i++)
     {    
 %>
     <tr class=xl25 height=19 style='height:14.25pt'>
      <td height=19 class=xl28 style='height:14.25pt'><%=dt.Rows[i]["item"]%></td>
      <td class=xl29 x:num ><%=dt.Rows[i]["shift_a"]%></td>
      <td class=xl29 x:num ><%=dt.Rows[i]["shift_b"]%></td>
      <td class=xl29 x:num ><%=dt.Rows[i]["shift_c"]%></td>
      <td class=xl29 x:num x:fmla="=B<%=(5+i)%>+C<%=(5+i)%>+D<%=(5+i)%>"></td>
      <td class=xl32 x:num align=right x:fmla="=IF(ISERROR( E<%=(5+i)%>/E5),"",E<%=(5+i)%>/E5)"></td>
      <td class=xl29 x:num ><%=dt.Rows[i]["cum_prev"]%></td>
      <td class=xl29 x:num ><%=dt.Rows[i]["cum_cur"]%></td>
      <td class=xl33 align=right x:num x:fmla="=IF(ISERROR( H<%=(5+i)%>/$H5),"",H<%=(5+i)%>/$H5)"></td>
     </tr>
 <%
     }
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'>Yield</td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(B6/B5),"",B6/B5)"></td>
  <td class=xl35 align=center x:fmla="=IF(ISERROR(C6/C5),"",C6/C5)"></td>
  <td class=xl35 align=center x:fmla="=IF(ISERROR(D6/D5),"",D6/D5)"></td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(E6/E5,"",E6/E5)"></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(G6/G5),"",G6/G5)"></td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(H6/H5),"",H6/H5)"></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_2", "'" + p_date + "'");
     
 %>
 <% 
     if (dt.Rows.Count > 0)
     {
         input_qty = Convert.ToDouble(dt.Rows[0]["total_shift"]);
         cum_input_qty = Convert.ToDouble(dt.Rows[0]["cum_cur"]);
     }
 %>
 
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td rowspan=2 height=39 class=xl112 style='border-bottom:2.0pt double black;
  height:29.25pt;border-top:none'>MAIN SLITTING</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift A</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift B</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift C</td>
  <td class=xl26 style='border-top:none'>TOTAL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td rowspan=2 class=xl110 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>(A+B+C)</td>
  <td class=xl27>Previous</td>
  <td class=xl27>Current</td>
 </tr>
 <% 
     for (int i = 0; i < dt.Rows.Count; i++)
     {    
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'><%=dt.Rows[i]["item"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_a"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_b"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_c"]%></td>
  <td class=xl29 x:num="0" x:fmla="=B<%=(13+i)%>+C<%=(13+i)%>+D<%=(13+i)%>"></td>
  <td class=xl32 align=center x:fmla="=IF(ISERROR( E<%=(13+i)%>/E13),"",E<%=(13+i)%>/E13)"> </td>
  <td class=xl29 align=right x:num><%=dt.Rows[i]["cum_prev"]%></td>
  <td class=xl29 x:fmla="=E<%=(13+i)%>+G<%=(13+i)%>"></td>
  <td class=xl33 align=right x:num x:fmla="=IF(ISERROR( H<%=(13+i)%>/$H13),"",H<%=(13+i)%>/$H13)"></td>
 </tr>
 <%
     }      
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Yield</td>
  <td class=xl35 align=center  x:fmla="=IF(ISERROR(B14/B13),"",B14/B13)"></td>
  <td class=xl35 align=center  x:fmla="=IF(ISERROR(C14/C13,"",C14/C13)"></td>
  <td class=xl35 align=center  x:fmla="=IF(ISERROR(D14/D13,"",D14/D13)"></td>
  <td class=xl35 align=center x:fmla="=IF(ISERROR(E14/E13,"",E14/E13)"></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(G14/G13,"",G14/G13)"></td>
  <td class=xl35 align=right x:num x:fmla="=IF(ISERROR(H14/H13,"",H14/H13)"></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_3", "'" + p_date + "'");
     
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td rowspan=2 height=39 class=xl112 style='border-bottom:2.0pt double black;
  height:29.25pt;border-top:none'>MINI SLITTING</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift A</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift B</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift C</td>
  <td class=xl26 style='border-top:none'>TOTAL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td rowspan=2 class=xl110 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>(A+B+C)</td>
  <td class=xl27>Previous</td>
  <td class=xl27>Current</td>
 </tr>
 <%
     for(int i=0; i<dt.Rows.Count;i++)
    {
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'><%=dt.Rows[i]["item"]%></td>
  <td class=xl29 x:num ><%=dt.Rows[i]["shift_a"]%></td>
  <td class=xl29 x:num ><%=dt.Rows[i]["shift_b"]%></td>
  <td class=xl29 x:num ><%=dt.Rows[i]["shift_c"]%></td>
  <td class=xl29 x:num="0" x:fmla="=B<%=(22+1)%>+C<%=(22+i)%>+D<%=(22+i)%>"></td>
  <td class=xl41 align=center x:fmla="=IF(ISERROR(E<%=(22+i)%>/E22),"",E<%=(22+i)%>/E22)"></td>
  <td class=xl29 x:num ><%=dt.Rows[i]["cum_prev"]%></td>
  <td class=xl29 x:num x:fmla="=E<%=(22+i)%>+G<%=(22+i)%>"></td>
  <td class=xl42 align=right x:num x:fmla="=IF(ISERROR(H<%=(22+i)%>/H22),"",H<%=(22+i)%>/H22)"></td>
 </tr>
 <%
    }
  %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Yield</td>
  <td class=xl43 align=center  x:fmla="=IF(ISERROR(B23/B22),"",B23/B22)"></td>
  <td class=xl43 align=center x:fmla="=IF(ISERROR(C23/C22),"",C23/C22)"></td>
  <td class=xl43 align=center x:fmla="=IF(ISERROR(D23/D22),"",D23/D22)"></td>
  <td class=xl43 align=center x:fmla="=IF(ISERROR(E23/E22),"",E23/E22)"></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43 align=right x:num x:fmla="=IF(ISERROR(G23/G22),"",G23/G22)"></td>
  <td class=xl43 align=right x:num x:fmla="=IF(ISERROR(H23/H22),"",H23/H22)"></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_4", "'" + p_date + "'");
     
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl46 style='height:14.25pt;border-top:none'>SALVAGE</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift A</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift B</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift C</td>
  <td class=xl26 style='border-top:none'>TOTAL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td rowspan=2 class=xl110 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl47 style='height:15.0pt'>RECUTTING ROLL</td>
  <td class=xl27>(A+B+C)</td>
  <td class=xl27>Previous</td>
  <td class=xl27>Current</td>
 </tr>
 <%
    for(int i=0; i<dt.Rows.Count;i++)        
    {
  %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'><%=dt.Rows[i]["item"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_a"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_b"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["shift_c"]%></td>
  <td class=xl29 x:num x:fmla="=B<%=(28+i)%>+C<%=(28+i)%>+D<%=(28+i)%>"></td>
  <td class=xl31 align=center  x:fmla="=IF(ISERROR(E<%=(28+i)%>/E28),"",E<%=(28+i)%>/E28)"></td>
  <td class=xl29 align=right x:num><%=dt.Rows[i]["cum_prev"]%></td>
  <td class=xl29 x:num  x:fmla="=E<%=(28+i)%>+G<%=(28+i)%>"></td>
  <td class=xl42 align=right x:num x:fmla="=IF(ISERROR(H<%=(28+i)%>/H28),"",H<%=(28+i)%>/H28)"></td>
 </tr>
 <%
    }
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Yield</td>
  <td class=xl43 align=center  x:fmla="=IF(ISERROR(B29/B28),"",B29/B28)"></td>
  <td class=xl43 align=center  x:fmla="=IF(ISERROR(C29/C28),"",C29/C28)"></td>
  <td class=xl43 align=center  x:fmla="=IF(ISERROR(D29/D28),"",D29/D28)"></td>
  <td class=xl43 align=center  x:fmla="=IF(ISERROR(E29/E28),"",E29/E28)"></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl43 align=right x:num x:fmla="=IF(ISERROR(G29/G28),"",G29/G28)"></td>
  <td class=xl43 align=right x:num x:fmla="=IF(ISERROR(H29/H28),"",H29/H28)"></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td rowspan=2 height=39 class=xl112 style='border-bottom:2.0pt double black;
  height:29.25pt;border-top:none'>RECLAIM</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift A</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift B</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>Shift C</td>
  <td class=xl26 style='border-top:none'>TOTAL</td>
  <td rowspan=2 class=xl26 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td class=xl26 style='border-top:none'>CUM.</td>
  <td rowspan=2 class=xl110 style='border-bottom:2.0pt double black;border-top:
  none'>%</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>(A+B+C)</td>
  <td class=xl27>Previous</td>
  <td class=xl27>Current</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'>RPP A</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl102>&nbsp;</td>
  <td class=xl100 align=right style='border-left:none' x:num
  x:fmla="=B34+C34+D34">0</td>
  <td class=xl99 align=center  x:fmla="=IF(ISERROR(E34/E37),"",E34/E37)"> </td>
  <td class=xl92 align=right x:num ></td>
  <td class=xl100 align=right x:num  x:fmla="=E34+G34"></td>
  <td class=xl101 align=right x:num  x:fmla="=IF(ISERROR(H34/H37),"",H34/H37)"></td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl91 style='height:14.25pt'>RPP B</td>
  <td class=xl102>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl100 align=right style='border-left:none' x:num
  x:fmla="=B35+C35+D35"></td>
  <td class=xl103 align=center x:fmla="=IF(ISERROR(E35/E37),"",E35/E37)"></td>
  <td class=xl102 align=right style='border-left:none' x:num></td>
  <td class=xl100 align=right style='border-left:none' x:num x:fmla="=E35+G35"></td>
  <td class=xl101 align=right x:num x:fmla="=IF(ISERROR(H35/H37),"",H35/H37)"></td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'>Lumps</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td class=xl54 align=right style='border-left:none' x:num
  x:fmla="=B36+C36+D36"></td>
  <td class=xl53 align=center style='border-left:none' x:fmla="=IF(ISERROR(E36/E37),"",E36/E37)"></td>
  <td class=xl52 align=right style='border-left:none' x:num></td>
  <td class=xl50 align=right style='border-left:none' x:num" x:fmla="=E36+G36"></td>
  <td class=xl51 align=right x:num x:fmla="=IF(ISERROR(H36/H37),"",H36/H37)"></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Total</td>
  <td class=xl55 align=right x:num x:fmla="=SUM(B34:B36)"></td>
  <td class=xl55 align=right style='border-left:none' x:num
  x:fmla="=SUM(C34:C36)"></td>
  <td class=xl55 align=right style='border-left:none' x:num
  x:fmla="=SUM(D34:D36)"></td>
  <td class=xl55 align=right style='border-left:none' x:num
  x:fmla="=SUM(E34:E36)"></td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-left:none'>&nbsp;</td>
  <td class=xl57 align=right style='border-left:none' x:num
  x:fmla="=SUM(H34:H36)"></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_5", "'" + p_date + "'");
     
 %>
 <tr class=xl25 height=20 style='page-break-before:always;height:15.0pt'>
  <td height=20 class=xl58 style='height:15.0pt;border-top:none'>FILM BREAKS</td>
  <td class=xl59 style='border-top:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl115 style='border-top:none'>A Grade</td>
  <td class=xl116 style='border-top:none' x:num x:fmla="=H14+H23+H29"></td>
  <td class=xl117 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt;border-top:none'>Shift</td>
  <td class=xl65 style='border-top:none'>Daily</td>
  <td class=xl65 style='border-top:none'>Cum.Prev.</td>
  <td class=xl66 style='border-top:none'>Cum.current</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl37>RPP</td>
  <td class=xl62 x:num x:fmla="=H34+H35"></td>  
  <td class=xl63>&nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'>A</td>
  <td class=xl48 align=right x:num><%=dt.Rows[0]["daily"] %></td>
  <td class=xl48 align=right x:num><%=dt.Rows[0]["cum_prev"] %></td>
  <td class=xl63 align=right x:num x:fmla="=B40+C40"></td>
  <td class=xl105></td>
  <td class=xl25></td>
  <td class=xl37>Scrap</td>
  <td class=xl62 x:fmla="=H24+H30"></td>
  <td class=xl63>&nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'>B</td>
  <td class=xl48 x:num><%=dt.Rows[1]["daily"] %></td>
  <td class=xl48 align=right x:num><%=dt.Rows[1]["cum_prev"] %></td>
  <td class=xl63 align=right x:num x:fmla="=B41+C41"></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl39>TOTAL</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'>C</td>
  <td class=xl48 x:num><%=dt.Rows[2]["daily"] %></td>
  <td class=xl48 align=right x:num><%=dt.Rows[2]["cum_prev"] %></td>
  <td class=xl63 align=right x:num x:fmla="=B42+C42"></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt'>total</td>
  <td class=xl69 align=right x:num x:fmla="=SUM(B40:B42)"></td>
  <td class=xl69 align=right style='border-left:none' x:num
  x:fmla="=SUM(C40:C42)"></td>
  <td class=xl70 align=right style='border-left:none' x:num
  x:fmla="=SUM(D40:D42)"></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_6", "'" + p_date + "'");
     dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_8", "'" + p_date + "'");
     
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt'>Resin Status</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>(Kg)</td>
  <td class=xl25></td>
  <td class=xl71></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt' x:str="   Grade"><span
  style='mso-spacerun:yes'>    </span>Grade<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl73 x:str="opening"><span
  style='mso-spacerun:yes'> </span>opening<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl73 x:str="in"><span style='mso-spacerun:yes'> </span>in<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl73 x:str="out"><span style='mso-spacerun:yes'> </span>out<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl74 x:str="closing"><span
  style='mso-spacerun:yes'> </span>closing<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
  <td class=xl71 colspan=2 style='mso-ignore:colspan'>Stock Status(Kg)</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl109 style='height:14.25pt' x:str="PP Resin ">PP
  Resin<span style='mso-spacerun:yes'> </span></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl76>Mill Roll</td>
  <td class=xl77 align=right style='border-left:none' x:num><%=dt1.Rows[0]["end_qty"]%></td>
  <td class=xl25></td>
 </tr>
 <%
     int n = 0;
     n = (dt1.Rows.Count) < dt.Rows.Count ? dt1.Rows.Count : dt.Rows.Count;
     for (int i = 0; i < n; i++)
         {
  %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'>&nbsp;&nbsp;&nbsp;<%=dt.Rows[i]["item_name"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["output_qty"]%></td>
  <td class=xl75 x:num><%=dt.Rows[i]["end_qty"]%></td>
  <td class=xl25></td>
  <td class=xl76 style='border-top:none' x:str><%=dt1.Rows[i+1]["loc_id"]%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none'
  x:num><%=dt1.Rows[i+1]["end_qty"]%></td>
  <td class=xl25></td>
 </tr>
 <%
     }
  %>
  <%
     
     for (int i = n; i < dt.Rows.Count; i++)
         {
  %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'>&nbsp;&nbsp;&nbsp;<%=dt.Rows[i]["item_name"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["output_qty"]%></td>
  <td class=xl75 x:num><%=dt.Rows[i]["end_qty"]%></td>
  <td class=xl25></td>
  <td class=xl76 style='border-top:none' x:str></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num></td>
  <td class=xl25></td>
 </tr>
 <%
     }
  %>
  <%
  for (int i = n+1; i < dt1.Rows.Count; i++)
         {
  %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'></td>
  <td class=xl29 x:num></td>
  <td class=xl29 x:num></td>
  <td class=xl29 x:num></td>
  <td class=xl75 x:num></td>
  <td class=xl25></td>
  <td class=xl76 style='border-top:none' x:str><%=dt1.Rows[i]["loc_id"]%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none'
  x:num><%=dt1.Rows[i]["end_qty"]%></td>
  <td class=xl25></td>
 </tr>
 <%
     }
  %>  
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt;border-top:none'>&nbsp;&nbsp;&nbsp;sub total</td>
  <td class=xl82 x:num x:fmla="=sum(B47:B<%=(47+dt.Rows.Count-1)%>)"></td>
  <td class=xl82 x:num x:fmla="=sum(C47:C<%=(47+dt.Rows.Count-1)%>)"></td>
  <td class=xl82 x:num x:fmla="=sum(D47:D<%=(47+dt.Rows.Count-1)%>)"></td>
  <td class=xl83 x:num x:fmla="=sum(E47:E<%=(47+dt.Rows.Count-1)%>)"></td>
  <td class=xl25></td>
  <td class=xl84></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
     dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpep00063_7", "'" + p_date + "'");
     
 %>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl109 style='height:15.0pt'>Additive</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td colspan=4 class=xl114 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
    for (int i=0; i<dt.Rows.Count ;i++)
    {
 %>
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td height=19 class=xl37 style='height:14.25pt'><%=dt.Rows[i]["item_name"] %></td>
  <td class=xl29 x:num><%=dt.Rows[i]["begin_qty"] %></td>
  <td class=xl29 x:num><%=dt.Rows[i]["input_qty"] %></td>
  <td class=xl29 x:num><%=dt.Rows[i]["output_qty"] %></td>
  <td class=xl75 x:num><%=dt.Rows[i]["end_qty"] %></td>
  <td colspan=4 class=xl106 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
  %> 
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>Sub Total</td>
  <td class=xl90 x:num x:fmla="=SUM(B53:B<%=(53+dt.Rows.Count-1)%>)"></td>
  <td class=xl90 x:num x:fmla="=SUM(C53:C<%=(53+dt.Rows.Count-1)%>)"></td>
  <td class=xl90 x:num x:fmla="=SUM(D53:D<%=(53+dt.Rows.Count-1)%>)"></td>
  <td class=xl89 x:num x:fmla="=SUM(E53:E<%=(53+dt.Rows.Count-1)%>)"></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=168 style='width:126pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=88 style='width:66pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
