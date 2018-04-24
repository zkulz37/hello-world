<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string sopk = "", delimethod = "";
    string pack_date="",po_no="",order_qty="",pack_intruc="",item_code="",item_name="";
    DataTable dt,dt2,dt3;
    sopk = Request.QueryString["sopk"];
    dt = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00030_cotton_1", "'" + sopk + "'");
    if(dt.Rows.Count>0)
    {
        pack_date=dt.Rows[0]["pack_date"].ToString();
        po_no=dt.Rows[0]["ref_po_no"].ToString();
        order_qty=dt.Rows[0]["order_qty"].ToString();
        pack_intruc=dt.Rows[0]["ATT01"].ToString();
        item_code=dt.Rows[0]["item_code"].ToString();
        item_name=dt.Rows[0]["item_name"].ToString();
        
    }
    dt2 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00030_cotton_2", "'" + sopk + "'");
    dt3 = ESysLib.TableReadOpenCursor("SALE.sp_dsep00030_cotton_3", "'" + sopk + "'");
 %>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsep00030_cotton_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsep00030_cotton_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsep00030_cotton_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>COTTON</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2010-01-07T03:29:13Z</o:LastPrinted>
  <o:Created>2009-10-29T06:19:25Z</o:Created>
  <o:LastSaved>2010-01-08T02:42:56Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.38in .23in .32in .52in;
	mso-header-margin:.27in;
	mso-footer-margin:.21in;}
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
.style20
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
	mso-style-name:"Normal_Cutting Ticket THA\#02";}
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
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center-across;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center-across;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style20;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl48
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\;\@";
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:gray;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:gray;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:gray;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:gray;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:gray;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl71
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	color:blue;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	color:#CCFFCC;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl111
	{mso-style-parent:style0;
	color:#CCFFCC;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl118
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl120
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl124
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl125
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"General\0022PCS\0022";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"General\0022PCS\0022";
	text-align:center;
	vertical-align:middle;}
.xl131
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl133
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl135
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl141
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl142
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl143
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl145
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl147
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl148
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl149
	{mso-style-parent:style0;
	color:#993300;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl150
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl151
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl153
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl154
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl155
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl156
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl157
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl159
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl160
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl161
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl162
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl163
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl164
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl165
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl166
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl167
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl168
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl169
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl170
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl171
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl172
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\0022PCS\0022";
	vertical-align:middle;}
.xl173
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl174
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl175
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl176
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl177
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl179
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl180
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl184
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl187
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl188
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl189
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl190
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl191
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl192
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl193
	{mso-style-parent:style0;
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
	mso-pattern:auto none;}
.xl194
	{mso-style-parent:style0;
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
.xl195
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl197
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl198
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl199
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl200
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl201
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl202
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl203
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl204
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl205
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl206
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl207
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl208
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl209
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl210
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl211
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl212
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl213
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl214
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl215
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl216
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl217
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl218
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl219
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl220
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ACTUAL PACKING LIST</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>75</x:Zoom>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>27</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$28:$G$32</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8175</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:Calculation>SemiAutomaticCalculation</x:Calculation>
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

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1002 style='border-collapse:
 collapse;table-layout:fixed;width:754pt'>
 <col class=xl25 width=7 span=2 style='mso-width-source:userset;mso-width-alt:
 256;width:5pt'>
 <col class=xl25 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl25 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl25 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl25 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl25 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl30 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <%
 for(int i=0;i<dt2.Rows.Count;i++)
 {
    %>
     <col class=xl25 width=0 style='mso-width-source:userset;
     mso-width-alt:1938;mso-outline-level:1'>
    <%   
 }
 %>
 <%
 for(int k=0;k<7-dt2.Rows.Count;k++)
 {
    %>
    <col class=xl25 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1938;mso-outline-level:1'>
    <%
 }
  %>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 mso-outline-parent:collapsed;width:55pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl25 width=8 style='mso-width-source:userset;mso-width-alt:292;
 width:6pt'>
 <tr class=xl25 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl25 width=7 style='height:8.25pt;width:5pt'></td>
  <td class=xl26 width=7 style='width:5pt'>&nbsp;</td>
  <td class=xl26 width=93 style='width:70pt'>&nbsp;</td>
  <td class=xl26 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl26 width=107 style='width:80pt'>&nbsp;</td>
  <td class=xl26 width=58 style='width:44pt'>&nbsp;</td>
  <td class=xl26 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl26 width=43 style='width:32pt'>&nbsp;</td>
  <td class=xl26 width=10 style='width:8pt'>&nbsp;</td>
  <td class=xl26 width=68 style='width:51pt'>&nbsp;</td>
  <td class=xl27 width=59 style='width:44pt'>&nbsp;</td>
  <td class=xl26 width=60 style='width:45pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=0>&nbsp;</td>
  <td class=xl26 width=0>&nbsp;</td>
  <td class=xl26 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl25 width=73 style='width:55pt'></td>
  <td class=xl25 width=8 style='width:6pt'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1025" type="#_x0000_t75"
   style='position:absolute;margin-left:38.25pt;margin-top:3.75pt;width:45.75pt;
   height:44.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_dsep00030_cotton_files/image001.emz" o:title=""/>
  </v:shape><v:shape id="Picture_x0020_2" o:spid="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:99pt;margin-top:4.5pt;width:416.25pt;
   height:27pt;z-index:2;visibility:visible'>
   <v:imagedata src="rpt_dsep00030_cotton_files/image002.emz" o:althref="rpt_dsep00030_cotton_files/image003.pcz"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:Anchor>
     5, 25, 1, 6, 16, 4, 4, 0</x:Anchor>
    <x:CF>Pict</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:51px;margin-top:5px;width:636px;
  height:59px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=61></td>
    <td width=20></td>
    <td width=555></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=3 align=left valign=top><img width=61 height=59
    src="rpt_dsep00030_cotton_files/image004.gif" v:shapes="Picture_x0020_3"></td>
   </tr>
   <tr>
    <td height=36></td>
    <td></td>
    <td align=left valign=top><img width=555 height=36
    src="rpt_dsep00030_cotton_files/image005.gif" v:shapes="Picture_x0020_2"></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=18 class=xl26 width=107 style='height:13.5pt;width:80pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl140>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl152>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl143>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl25 style='height:5.25pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl152>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl143>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=18 class=xl153 align=center style='mso-ignore:colspan;border-right:
  1.0pt solid black'><span style='mso-spacerun:yes'>      </span>AP BINH PHUOC
  A, BINH CHUAN, THUAN AN, BINH DUONG, VIETNAM</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl25 style='height:6.75pt'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl154>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl145>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl116 align=center>ACTUAL PACKING LIST</td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=8 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl146>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl38 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl117>DATE:</td>
  <td class=xl38></td>
  <td class=xl118 x:num><%=pack_date %></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl119 colspan=2 style='mso-ignore:colspan'>CUSTOMER :</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl120 colspan=2 style='mso-ignore:colspan'>IN-LINE</td>
  <td class=xl120 colspan=8 style='mso-ignore:colspan;border-right:1.0pt solid black'>STYLE
  DISC: <%=item_name %></td>
  <td class=xl148>&nbsp;</td>
 </tr>
 <tr class=xl38 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl117>PO#</td>
  <td class=xl38></td>
  <td class=xl123 style='border-top:none' x:num><%=po_no %></td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl124 colspan=2 style='mso-ignore:colspan'>ORDER QTY:</td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl125 x:num><%=order_qty %></td>
  <td class=xl126>PCS</td>
  <td class=xl124 colspan=3 style='mso-ignore:colspan'>SHIPPED<span
  style='mso-spacerun:yes'>  </span>QTY:</td>
  <td colspan=4 class=xl172 align=right x:num="4932">4,932PCS</td>
  <td class=xl127><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl148>&nbsp;</td>
 </tr>
 <tr class=xl38 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl117>STYLE#</td>
  <td class=xl38></td>
  <td class=xl123 style='border-top:none'><%=item_code %></td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl119 colspan=2 style='mso-ignore:colspan'>CARTON QTY:</td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl128 style='border-top:none' x:num>15</td>
  <td class=xl129 style='border-top:none'>&nbsp;</td>
  <td class=xl124 colspan=3 style='mso-ignore:colspan'>CONTAINER#:</td>
  <td class=xl38></td>
  <td class=xl120></td>
  <td class=xl130></td>
  <td class=xl38></td>
  <td class=xl131>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl25 style='height:5.25pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl45></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl46 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl46 style='height:20.25pt'></td>
  <td class=xl47>&nbsp;</td>
  <td colspan=18 class=xl48 align=center style='mso-ignore:colspan;border-right:
  1.0pt solid black'>PACKING INSTRUCTION: <%=pack_intruc %></td>
  <td class=xl149>&nbsp;</td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl25 style='height:5.25pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl51></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl53 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl53 style='height:27.75pt'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55>Style</td>
  <td class=xl56 style='border-left:none'>Po</td>
  <td class=xl57 style='border-left:none'>School</td>
  <td class=xl57>S.C</td>
  <td class=xl57>Licensing</td>
  <td class=xl58 align=center>Box#</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59 width=59 style='width:44pt'>Box's qty</td>
   <%
    for(int i=0;i<dt2.Rows.Count;i++)
    {
    %>
        <td class=xl60 width=60 style='border-top:none;width:45pt'><%=dt2.Rows[i]["spec_nm"] %></td>
    <%
        
    }
   %>
   <%
   for(int k=0;k<7-dt2.Rows.Count;k++)
   {
   %>
        <td class=xl56 style='border-top:none;border-left:none'></td>
   <%
   }
    %>
  <td class=xl62 width=73 style='border-top:none;border-left:none;width:55pt'>TTL<br>
    Per Box</td>
  <td class=xl63 style='border-top:none'>TTL</td>
  <td class=xl150>&nbsp;</td>
 </tr>
 <tr class=xl53 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl53 style='height:6.0pt'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-left:none'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67 width=59 style='width:44pt'>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-left:none'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl150>&nbsp;</td>
 </tr>
 <tr class=xl69 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=2 class=xl71 align=center style='mso-ignore:colspan'>Size Ratio</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl74 width=59 style='border-top:none;width:44pt'>&nbsp;</td>
  <td class=xl75 width=60 style='border-top:none;width:45pt' x:num>2</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt' x:num>2</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt' x:num>2</td>
  <td class=xl76 width=0 style='border-top:none' x:num>2</td>
  <td class=xl77 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
 </tr>
 
  <%
   
   %>
  
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=<%=21 %> class=xl212 style='border-bottom:.5pt solid black;border-top:
  none'><%=item_code%></td>
  <td rowspan=<%=21 %> class=xl215 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=po_no %></td>
  <td rowspan=5 class=xl160 style='border-bottom:.5pt solid black'>ALABAMA</td>
  <td rowspan=5 class=xl160 style='border-bottom:.5pt solid black' x:num>101</td>
  <td rowspan=5 class=xl160 style='border-bottom:.5pt solid black'>CLC</td>
  <td class=xl80 style='border-left:none' x:num>1</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num >1</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84 x:num>7</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num >7</td>
  <td class=xl86 x:num >7</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J17+1">2</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H18+K18-1">2</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>12</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L18:R18)">12</td>
  <td class=xl86 x:num x:fmla="=S18*$K18">12</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J18+1">3</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H19+K19-1">3</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>21</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L19:R19)">21</td>
  <td class=xl86 x:num x:fmla="=S19*$K19">21</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J19+1">4</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H20+K20-1">4</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L20:R20)">0</td>
  <td class=xl86 x:num x:fmla="=S20*$K20">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J20+1">5</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H21+K21-1">5</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L21:R21)">0</td>
  <td class=xl86 x:num x:fmla="=S21*$K21">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl204 style='border-left:none'>TOTAL:</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(K17:K21)">5</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L17:L21)">7</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M17:M21)">12</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P17:P21)">21</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(S17:S21)">40</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(T17:T21)">40</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 
 
 
 
  
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=4 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none'>APPALAC ST</td>
  <td rowspan=4 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none' x:num>102</td>
  <td rowspan=4 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none'>LRG</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J21+1">6</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H23+K23-1">6</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84 x:num>6</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L23:R23)">6</td>
  <td class=xl86 x:num x:fmla="=S23*$K23">6</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J23+1">7</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H24+K24-1">7</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>15</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L24:R24)">15</td>
  <td class=xl86 x:num x:fmla="=S24*$K24">15</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J24+1">8</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H25+K25-1">8</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>20</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=SUM(L25:R25)">20</td>
  <td class=xl86 x:num x:fmla="=S25*$K25">20</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J25+1">9</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H26+K26-1">9</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L26:R26)">0</td>
  <td class=xl86 x:num x:fmla="=S26*$K26">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl204 style='border-left:none'>TOTAL:</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(K23:K26)">4</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L23:L26)">6</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M23:M26)">15</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P23:P26)">20</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(S23:S26)">41</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(T23:T26)">41</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=5 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none'>BAYLOR</td>
  <td rowspan=5 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none' x:num>120</td>
  <td rowspan=5 class=xl157 style='border-bottom:.5pt solid black;border-top:
  none'>CLC</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J26+1">10</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H28+K28-1">10</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84 x:num>16</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L28:R28)">16</td>
  <td class=xl86 x:num x:fmla="=S28*$K28">16</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J28+1">11</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H29+K29-1">11</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>20</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L29:R29)">20</td>
  <td class=xl86 x:num x:fmla="=S29*$K29">20</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J29+1">12</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H30+K30-1">12</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>24</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L30:R30)">24</td>
  <td class=xl86 x:num x:fmla="=S30*$K30">24</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J30+1">13</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H31+K31-1">13</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L31:R31)">0</td>
  <td class=xl86 x:num x:fmla="=S31*$K31">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl83 style='border-left:none' x:num x:fmla="=J31+1">14</td>
  <td class=xl81>~</td>
  <td class=xl82 x:num x:fmla="=H32+K32-1">14</td>
  <td class=xl83 x:num>1</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L32:R32)">0</td>
  <td class=xl86 x:num x:fmla="=S32*$K32">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl192 style='border-right:.5pt solid black;border-left:
  none'>TOTAL:</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(K28:K32)">5</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L28:L32)">16</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M28:M32)">20</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P28:P32)">24</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(S28:S32)">60</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(T28:T32)">60</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 
 
 
 
 
 
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl136 style='border-top:none;border-left:none'>IOWA ST</td>
  <td class=xl115 style='border-top:none;border-left:none' x:num>205</td>
  <td class=xl115 style='border-top:none;border-left:none'>LRG</td>
  <td rowspan=3 class=xl198 style='border-bottom:.5pt solid black;border-top:
  none' x:num>265</td>
  <td class=xl81>~</td>
  <td rowspan=3 class=xl201 style='border-bottom:.5pt solid black;border-top:
  none' x:num>265</td>
  <td rowspan=3 class=xl174 style='border-bottom:.5pt solid black;border-top:
  none' x:num>1</td>
  <td class=xl84 style='border-left:none' x:num>6</td>
  <td class=xl85 style='border-left:none' x:num>1</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>9</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L34:R34)">16</td>
  <td class=xl86 x:num x:fmla="=S34*$K34">16</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>TEXAS A&amp;M</td>
  <td class=xl115 style='border-top:none;border-left:none' x:num>359</td>
  <td class=xl115 style='border-top:none;border-left:none'>LRG</td>
  <td class=xl81>~</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>1</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>1</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L35:R35)">2</td>
  <td class=xl86 x:num x:fmla="=S35*$K34">2</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl115 style='border-top:none;border-left:none'>OHIO ST</td>
  <td class=xl115 style='border-top:none;border-left:none' x:num>290</td>
  <td class=xl115 style='border-top:none;border-left:none'>IND</td>
  <td class=xl81>~</td>
  <td class=xl84 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none' x:num>2</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-left:none' x:num x:fmla="=+SUM(L36:R36)">2</td>
  <td class=xl86 x:num x:fmla="=S36*$K34">2</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl192 style='border-right:.5pt solid black;border-left:
  none'>TOTAL:</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(K34:K36)">1</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L34:L36)">6</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M34:M36)">4</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P34:P36)">10</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(S34:S36)">20</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(T34:T36)">20</td>
  <td class=xl156 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td class=xl155>&nbsp;</td>
  <td class=xl87 align=center style='border-top:none;border-left:none'>G.Total</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl112 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl112 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl112 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl113 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl113 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,K17:K37)">15</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,L17:L37)">35</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,M17:M37)">51</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,N17:N37)">0</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,O17:O37)">0</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,P17:P37)">75</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,Q17:Q37)">0</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,R17:R37)">0</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,S17:S37)">161</td>
  <td class=xl114 style='border-top:none' x:num
  x:fmla="=SUMIF($E$17:$E$37,&quot;TOTAL:&quot;,T17:T37)">161</td>
  <td class=xl156>&nbsp;</td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=7 class=xl91 style='mso-ignore:colspan'></td>
  <td class=xl110></td>
  <td colspan=10 class=xl111 style='mso-ignore:colspan'></td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl205>SHIPMENT SUMMARY</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl53 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl53 style='height:27.75pt'></td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55>Style</td>
  <td class=xl56 style='border-left:none'>Po</td>
  <td class=xl57 style='border-left:none'>School</td>
  <td class=xl57>S.C</td>
  <td class=xl57>Licensing</td>
  <td class=xl58 align=center>Box#</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59 width=59 style='width:44pt'>Box's qty</td>
  <td class=xl60 width=60 style='width:45pt'>S</td>
  <td class=xl61 width=53 style='border-left:none;width:40pt'>M</td>
  <td class=xl61 width=53 style='border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl61 width=53 style='border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl61 width=53 style='border-left:none;width:40pt'>L</td>
  <td class=xl61 width=0 style='border-left:none'>XL</td>
  <td class=xl56 style='border-left:none'>2XL</td>
  <td class=xl62 width=73 style='border-left:none;width:55pt'>TTL<br>
    Per Box</td>
  <td class=xl63>TTL</td>
  <td class=xl150>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=20 class=xl186 style='border-bottom:1.0pt solid black;border-top:
  none' x:fmla="=E10">COTS1408H</td>
  <td rowspan=20 class=xl189 style='border-bottom:1.0pt solid black;border-top:
  none' x:num x:fmla="=E9">3992</td>
  <td rowspan=5 class=xl186 style='border-bottom:1.0pt solid black;border-top:
  none'>ALABAMA</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none' x:num>101</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none'>CLC</td>
  <td colspan=3 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>21</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>21</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L42:R42)">73</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>8</td>
  <td class=xl132 style='border-left:none' x:num>13</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>22</td>
  <td class=xl132 style='border-left:none' x:num>22</td>
  <td class=xl132 style='border-left:none' x:num>13</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L43:R43)">78</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L44:R44)">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L43:L44)">8</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M43:M44)">13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P43:P44)">22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(Q43:Q44)">22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(R43:R44)">13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L45:R45)">78</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl169 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=L45-L42">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=M45-M42">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=P45-P42">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=Q45-Q42">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=R45-R42">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L46:R46)">5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=5 class=xl186 style='border-bottom:1.0pt solid black;border-top:
  none'>APPLALAC ST</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none' x:num>102</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none'>LRG</td>
  <td colspan=3 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>20</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>20</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L47:R47)">72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>7</td>
  <td class=xl132 style='border-left:none' x:num>16</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>20</td>
  <td class=xl132 style='border-left:none' x:num>20</td>
  <td class=xl132 style='border-left:none' x:num>13</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L48:R48)">76</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L49:R49)">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L48:L49)">7</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M48:M49)">16</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P48:P49)">20</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(Q48:Q49)">20</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(R48:R49)">13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L50:R50)">76</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl169 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=L50-L47">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=M50-M47">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=P50-P47">0</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=Q50-Q47">0</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=R50-R47">2</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L51:R51)">4</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=5 class=xl186 style='border-bottom:1.0pt solid black;border-top:
  none'>VIRG TECH</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none' x:num>382</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none'>LRG</td>
  <td colspan=3 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L52:R52)">72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>15</td>
  <td class=xl132 style='border-left:none' x:num>17</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none' x:num>17</td>
  <td class=xl132 style='border-left:none' x:num>17</td>
  <td class=xl132 style='border-left:none' x:num>11</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L53:R53)">77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl85 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L54:R54)">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L53:L54)">15</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M53:M54)">17</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P53:P54)">17</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(Q53:Q54)">17</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(R53:R54)">11</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L55:R55)">77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl169 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=L55-L52">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=M55-M52">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=P55-P52">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=Q55-Q52">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=R55-R52">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L56:R56)">5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td rowspan=5 class=xl186 style='border-bottom:1.0pt solid black;border-top:
  none'>WISCONSIN</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none' x:num>393</td>
  <td rowspan=5 class=xl167 style='border-bottom:1.0pt solid black;border-top:
  none'>CLC</td>
  <td colspan=3 class=xl164 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl92 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>21</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L57:R57)">72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L58:R58)">77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl134 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl132 style='border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L59:R59)">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl161 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl134 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L58:L59)">13</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(M58:M59)">15</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(P58:P59)">22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(Q58:Q59)">18</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(R58:R59)">9</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num x:fmla="=SUM(L60:R60)">77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl169 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=L60-L57">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=M60-M57">1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=P60-P57">1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=Q60-Q57">2</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num
  x:fmla="=R60-R57">0</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L61:R61)">5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=5 rowspan=5 class=xl177 style='border-right:.5pt solid black;
  border-bottom:1.0pt solid black'>G.TOTAL:</td>
  <td colspan=3 class=xl218 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,L42:L61)">39</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,M42:M61)">57</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,N42:N61)">0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,O42:O61)">0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,P42:P61)">78</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,Q42:Q61)">73</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,R42:R61)">42</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,S42:S61)">0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;ORDER Q'TY&quot;,T42:T61)">289</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl209 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,L42:L61)">43</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,M42:M61)">61</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,N42:N61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,O42:O61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,P42:P61)">81</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,Q42:Q61)">77</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,R42:R61)">46</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,S42:S61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;1ST SHIPPED Q'TY&quot;,T42:T61)">308</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl209 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,L42:L61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,M42:M61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,N42:N61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,O42:O61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,P42:P61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,Q42:Q61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,R42:R61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,S42:S61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;2nd SHIPPED Q'TY&quot;,T42:T61)">0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl209 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,L42:L61)">43</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,M42:M61)">61</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,N42:N61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,O42:O61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,P42:P61)">81</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,Q42:Q61)">77</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,R42:R61)">46</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,S42:S61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;TTL SHIPPED Q'TY&quot;,T42:T61)">308</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl206 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl139 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,L42:L61)">4</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,M42:M61)">4</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,N42:N61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,O42:O61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,P42:P61)">3</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,Q42:Q61)">4</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,R42:R61)">4</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,S42:S61)">0</td>
  <td class=xl138 style='border-left:none' x:num
  x:fmla="=SUMIF($H$42:$J$61,&quot;BALANCE&quot;,T42:T61)">19</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl25 style='height:5.25pt'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl102>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl147>&nbsp;</td>
 </tr>
 <tr class=xl104 height=18 style='height:13.5pt'>
  <td height=18 colspan=3 class=xl104 style='height:13.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl105 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td class=xl108>&nbsp;</td>
  <td colspan=9 class=xl109 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=7 style='width:5pt'></td>
  <td width=7 style='width:5pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=8 style='width:6pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
