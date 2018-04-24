<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
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
    decimal l_total_due_hotel = 0, l_total_due_golf = 0,l_total_due_hotel_golf=0,l_ex_rate=0,l_total_due_hotel_golf_usd=0;
   string  l_tht_room_allocate_pk= Request.QueryString["p_tht_room_allocate_pk"];
	string  l_cashier_pk= Request.QueryString["p_cashier_pk"];
	string l_printed_yn= Request.QueryString["p__printed_yn"];
	string  l_paymethod= Request.QueryString["p_paymethod"];
	string l_parameter = "'" +  l_tht_room_allocate_pk + "','" + l_cashier_pk + "','" +l_printed_yn + "','" +  l_paymethod + "'";
	string l_parameter_1= "'888','" + l_cashier_pk + "','" +l_printed_yn + "','" +  l_paymethod + "'";
	
    DataTable dtHotel,dtGolf;
    dtHotel = ESysLib.TableReadOpenCursor("crm.SP_RPT_HTFO00040_HOTEL_PKG",l_parameter);
    dtGolf = ESysLib.TableReadOpenCursor("crm.SP_RPT_HTFO00040_GOLF_SEND_PKG",l_parameter);
	
	for (int j= 0; j < dtGolf.Rows.Count; j++)   
    {
		if(dtGolf.Rows[j][2].ToString().Trim() != "")
		{
			l_total_due_golf += Decimal.Parse(dtGolf.Rows[j][2].ToString());
		}
	}
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00040_print_Hotel_Golf_Package_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_htfo00040_print_Hotel_Golf_Package_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_htfo00040_print_Hotel_Golf_Package_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-03-01T02:06:01Z</o:LastPrinted>
  <o:Created>2010-11-30T08:32:49Z</o:Created>
  <o:LastSaved>2011-03-01T02:06:09Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.5in .2in .5in .51in;
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
	padding:0px;
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"Short Date";}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl44
	{mso-style-parent:style0;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl47
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#969696;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl62
	{mso-style-parent:style0;
	text-align:right;}
.xl63
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";}
.xl66
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#969696;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#969696;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;}
.xl88
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:center;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:center;}
.xl110
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	text-align:left;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9195</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2072 style='border-collapse:
 collapse;table-layout:fixed;width:1555pt'>
 <col class=xl44 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col width=64 style='width:48pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1499;width:31pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td height=31 width=37 style='height:23.25pt;width:28pt' align=left
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
   margin-left:1.5pt;margin-top:3.75pt;width:114pt;height:39.75pt;z-index:1'>
   <v:imagedata src="rpt_htfo00040_print_Hotel_Golf_Package_files/image001.jpg"
    o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:5px;width:152px;
  height:53px'><img width=152 height=53
  src="rpt_htfo00040_print_Hotel_Golf_Package_files/image002.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl24 width=37 style='height:23.25pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl25 width=72 style='width:54pt'></td>
  <td class=xl25 width=66 style='width:50pt'></td>
  <td class=xl25 width=59 style='width:44pt'></td>
  <td class=xl26 width=51 style='width:38pt'></td>
  <td width=41 style='width:31pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1032" type="#_x0000_t75" style='position:absolute;margin-left:.75pt;
   margin-top:2.25pt;width:111.75pt;height:39.75pt;z-index:2'>
   <v:imagedata src="rpt_htfo00040_print_Hotel_Golf_Package_files/image003.jpg"
    o:title="HuynDai_Amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:30px;margin-top:9px;width:171px;
  height:34px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=68></td>
    <td width=17></td>
    <td width=86></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=3 align=left valign=top><img width=68 height=34
    src="rpt_htfo00040_print_Hotel_Golf_Package_files/image005.jpg" v:shapes="_x0000_s1030"></td>
   </tr>
   <tr>
    <td height=28></td>
    <td></td>
    <td align=left valign=top><img width=86 height=28
    src="rpt_htfo00040_print_Hotel_Golf_Package_files/image006.jpg" v:shapes="_x0000_s1031"></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl25 width=51 style='height:23.25pt;width:38pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=41 style='width:31pt'></td>
  <td class=xl25 width=46 style='width:35pt'></td>
  <td class=xl25 width=67 style='width:50pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl24 width=47 style='width:35pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl25 width=57 style='width:43pt'></td>
  <td class=xl25 width=46 style='width:35pt'></td>
  <td class=xl25 width=69 style='width:52pt'></td>
  <td class=xl25 width=56 style='width:42pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl24 width=39 style='width:29pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl25 width=50 style='width:38pt'></td>
  <td class=xl25 width=43 style='width:32pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl44 style='height:20.25pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl93>GUEST FOLIO</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td class=xl28></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td class=xl28></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl46 style='height:15.0pt'>Invoice:</td>
  <td colspan=5 class=xl111><%=dtHotel.Rows[0][1]%></td>
  <td colspan=2 class=xl46>Print Date:</td>
  <td colspan=2 class=xl86><%=dtHotel.Rows[0][0]%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'></td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl92 style='height:15.0pt'>Guest Name :</td>
  <td colspan=5 class=xl95><%=dtHotel.Rows[0][2]%></td>
  <td colspan=2 class=xl91>Cashier# :</td>
  <td colspan=2 class=xl95 style='border-right:1.0pt solid black'><%=dtHotel.Rows[0][6]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl94 style='height:15.0pt'>Arrival :</td>
  <td colspan=5 class=xl96><%=dtHotel.Rows[0][7]%></td>
  <td colspan=2 class=xl46>Departure:</td>
  <td colspan=2 class=xl96 style='border-right:1.0pt solid black'><%=dtHotel.Rows[0][8]%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl94 style='height:15.0pt'>Room# :</td>
  <td colspan=5 class=xl69 x:num><%=dtHotel.Rows[0][5]%></td>
  <td colspan=2 class=xl46>Nights :</td>
  <td colspan=2 class=xl109 style='border-right:1.0pt solid black' x:num><%=dtHotel.Rows[0][12]%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl100 style='height:15.0pt'>Hotel:</td>
  <td colspan=9 class=xl101 style='border-right:1.0pt solid black'><%=dtHotel.Rows[0][23]%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt;border-top:none'>No.</td>
  <td colspan=6 class=xl89>Description</td>
  <td colspan=2 class=xl89>Price</td>
  <td colspan=2 class=xl89 style='border-right:1.0pt solid black'>Amount</td>
  <td colspan=24 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dtHotel.Rows.Count; i++) 
     {
		
			l_total_due_hotel = Decimal.Parse(dtHotel.Rows[0][18].ToString());   
			l_ex_rate= Decimal.Parse(dtHotel.Rows[0][9].ToString());   
		
%>
 <tr class=xl32 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl59 style='height:18.0pt' x:num><%=i+1%></td>
  <td colspan=6 class=xl88><%=dtHotel.Rows[i][11]%></td>
  <td colspan=2 class=xl90 x:num><%=dtHotel.Rows[i][13]%></td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black'
  x:num><%=dtHotel.Rows[i][14]%></td>
  <td class=xl36></td>
  <td colspan=5 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
          %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl45 style='height:18.0pt'>&nbsp;</td>
  <td colspan=8 class=xl85>Sub Total</td>
  <td colspan=2 class=xl106 style='border-right:1.0pt solid black'
  x:num><%=Decimal.Parse(dtHotel.Rows[0][15].ToString()) %></td>
  <td></td>
  <td colspan=9 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=9 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl60 style='height:17.25pt'>&nbsp;</td>
  <td colspan=3 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl70>Discount amount :</td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black' x:num><%=dtHotel.Rows[0][19]%></td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl60 style='height:17.25pt'>&nbsp;</td>
  <td colspan=3 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl70>Pre paid/Deposit:</td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black' x:num><%=dtHotel.Rows[0][20]%></td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl60 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl70>SVC Charge 5%:</td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black'
  x:num><%=dtHotel.Rows[0][16]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl60 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl70>VAT Charge 10%:</td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black'
  x:num><%=dtHotel.Rows[0][17]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl46>Total:</td>
  <td colspan=2 class=xl80 style='border-right:1.0pt solid black' x:num><%=Decimal.Parse(dtHotel.Rows[0][18].ToString()) %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%
 if( dtGolf.Rows.Count>0)
 {
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl76 style='border-right:1.0pt solid black;
  height:15.0pt'>Golf/Other room fees:</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl58 style='height:15.0pt;border-top:none'>No</td>
  <td colspan=8 class=xl67>Description</td>
  <td colspan=2 class=xl67 style='border-right:1.0pt solid black'>Amount</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int j= 0; j < dtGolf.Rows.Count; j++)   
     {
%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl60 style='height:15.0pt' x:num><%=j+1%></td>
  <td colspan=8 class=xl69><%=dtGolf.Rows[j][1]%></td>
  <td colspan=2 class=xl73 style='border-right:1.0pt solid black' x:num><%=dtGolf.Rows[j][2]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%}%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl49 style='height:15.0pt'>&nbsp;</td>
  <td colspan=8 class=xl85>Sub Total</td>
  <td colspan=2 class=xl82 style='border-right:1.0pt solid black' x:num
  ><%=l_total_due_golf%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <%}%>
 <%
		//l_total_due_golf
		l_total_due_hotel_golf=l_total_due_hotel +l_total_due_golf ; 
		l_total_due_hotel_golf_usd=Math.Round(l_total_due_hotel_golf/l_ex_rate,2);
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl46>Paid:</td>
  <td colspan=2 class=xl35 style='border-right:1.0pt solid black' x:num=><%=l_total_due_hotel_golf%></td>
  <td class=xl43></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl46></td>
  <td colspan=2 class=xl84 ></td>
  <td class=xl62>$</td>
  <td class=xl63 align=right x:num><%=l_total_due_hotel_golf_usd%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl46>Payment method:</td>
  <td colspan=4 class=xl84 style='border-right:1.0pt solid black'><%=dtHotel.Rows[0][21]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl37 style='border-right:1.0pt solid black'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl72 style='height:15.0pt'>In word:</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl64 style='border-right:1.0pt solid black;
  height:15.0pt'><%if(l_total_due_hotel_golf_usd > 0){%><%=CommondLib.Num2EngText(l_total_due_hotel_golf_usd.ToString(), "USD") %><%}%></td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl64 style='height:15.0pt'>Exchange rate (VND / USD):</td>
  <td colspan=1 class=xl112 style='mso-ignore:colspan' x:num><%=dtHotel.Rows[0][9]%></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>&nbsp;</td>
  <td colspan=3 class=xl105>Cashier's Signature</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl105>Guest's Signature</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=24 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl97 style='height:15.0pt'>Công ty TNHH HYUNDAI AMCO VINA</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl97 style='height:15.0pt'>Website:
  www.songgia.com / E-mail : marketing@songgia.com</td>
  <td></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl55 style='height:15.0pt'>Ch&#7881; xu&#7845;t
  hóa &#273;&#417;n GTGT không quá 5 ngày k&#7875; t&#7915; ngày in bill và
  ph&#7843;i cùng tháng.</td>
  <td></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl55 colspan=7 style='height:15.0pt;mso-ignore:colspan'>Only
  issue VAT invoice less than 5 days from the date in the bill and in the same
  month.</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl56 style='height:7.5pt'>&nbsp;</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=8 height=16 class=xl55 style='height:12.0pt'>HYUNDAI AMCO VINA Co., Ltd</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td colspan=24 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=8 height=16 class=xl55 style='height:12.0pt'>Song Gia Resort
  Complex Golf &amp; Coutry Club</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td colspan=24 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=8 height=16 class=xl55 style='height:12.0pt'>Ch&#7907;
  T&#7893;ng, L&#432;u Ki&#7871;m, Th&#7911;y Nguyên, H&#7843;i Phòng -
  Vi&#7879;t Nam</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td colspan=24 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=8 height=16 class=xl55 style='height:12.0pt'>Tel.:
  (+84)31-396-3333 / Fax.: (+84)31-396-3332</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td colspan=24 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl50 style='height:6.0pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl52 style='height:15.0pt'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'></td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'></td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'></td>
  <td colspan=34 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
