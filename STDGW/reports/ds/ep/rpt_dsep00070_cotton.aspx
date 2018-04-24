<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string sopk = "";
    string pack_date = "", po_no = "", order_qty = "", pack_intruc = "", style_id = "", style_spec = "", shipped_qty = "", cust_name = "", carton_qty = "", container_no="";
    
    DataTable dt,dt2,dt3;
    sopk = Request.QueryString["sopk"];
    dt = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00070_cotton_1", "'" + sopk + "'");
    
    if(dt.Rows.Count>0)
    {
        pack_date=dt.Rows[0]["pack_date"].ToString();
        po_no=dt.Rows[0]["ref_po_no"].ToString();
        order_qty = dt.Rows[0]["ord_qty"].ToString();
        pack_intruc=dt.Rows[0]["pack_ins"].ToString();
        style_id = dt.Rows[0]["style_id"].ToString();
        style_spec =dt.Rows[0]["style_spec"].ToString();
        cust_name = dt.Rows[0]["cust_name"].ToString();
        shipped_qty = dt.Rows[0]["shipped_qty"].ToString();
        container_no = dt.Rows[0]["container_no"].ToString();
        carton_qty = dt.Rows[0]["carton_qty"].ToString();
    }
    
    dt2 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00070_cotton_2", "'" + sopk + "'");
    dt3 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00070_cotton_3", "'" + sopk + "'");
 %>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsep00030_cotton_3_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsep00030_cotton_3_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsep00030_cotton_3_files/oledata.mso">
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
  <o:LastSaved>2010-01-08T08:10:27Z</o:LastSaved>
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
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl159
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl160
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl161
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl162
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl163
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl164
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl165
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl166
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl167
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl168
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl169
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl170
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl171
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl172
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl173
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl174
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl175
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
.xl176
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
.xl177
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
.xl178
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
.xl179
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
.xl180
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
.xl181
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
.xl182
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
.xl183
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
.xl184
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
.xl185
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
.xl186
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
.xl187
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
.xl188
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl189
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
.xl190
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
.xl191
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
.xl192
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
.xl193
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
.xl194
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
.xl195
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
.xl196
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
.xl197
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
.xl198
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
.xl199
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
.xl200
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
.xl201
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
.xl202
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
.xl203
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
.xl204
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
.xl205
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
.xl206
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
.xl207
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl208
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
.xl209
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
.xl210
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
.xl211
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\0022PCS\0022";
	vertical-align:middle;}
.xl212
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl213
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
.xl214
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
.xl215
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
.xl216
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
.xl217
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl218
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
.xl219
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
.xl220
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
.xl221
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
       <x:RangeSelection>$E$28:$G$33</x:RangeSelection>
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
   <v:imagedata src="rpt_dsep00030_cotton_3_files/image001.emz" o:title=""/>
  </v:shape><v:shape id="Picture_x0020_2" o:spid="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:99pt;margin-top:4.5pt;width:416.25pt;
   height:27pt;z-index:2;visibility:visible'>
   <v:imagedata src="rpt_dsep00030_cotton_3_files/image002.emz" o:althref="rpt_dsep00030_cotton_3_files/image003.pcz"
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
    src="rpt_dsep00030_cotton_3_files/image004.gif" v:shapes="Picture_x0020_3"></td>
   </tr>
   <tr>
    <td height=36></td>
    <td></td>
    <td align=left valign=top><img width=555 height=36
    src="rpt_dsep00030_cotton_3_files/image005.gif" v:shapes="Picture_x0020_2"></td>
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
  1.0pt solid black'>AP BINH PHUOC
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
  <td class=xl120 colspan=2 style='mso-ignore:colspan'><%=cust_name %></td>
  <td class=xl120 colspan=8 style='mso-ignore:colspan;border-right:1.0pt solid black'>STYLE
  DISC: <%=style_spec %></td>
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
  <td class=xl124 colspan=3 style='mso-ignore:colspan'>SHIPPED QTY:</td>
  <td colspan=4 class=xl211 align=right x:num=""><%=shipped_qty%> PCS</td>
  <td class=xl127><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl148>&nbsp;</td>
 </tr>
 <tr class=xl38 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl117>STYLE#</td>
  <td class=xl38></td>
  <td class=xl123 style='border-top:none'><%=style_id %></td>
  <td class=xl43 style='border-top:none'>&nbsp;</td>
  <td class=xl119 colspan=2 style='mso-ignore:colspan'>CARTON QTY:</td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl128 style='border-top:none' x:num><%=carton_qty%></td>
  <td class=xl129 style='border-top:none'>&nbsp;</td>
  <td class=xl124 colspan=3 style='mso-ignore:colspan'>CONTAINER#:</td>
  <td class=xl38></td>
  <td class=xl120><%=container_no%></td>
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
  <td colspan=2 class=xl71 align=center style='mso-ignore:colspan'></td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl74 width=59 style='border-top:none;width:44pt'>&nbsp;</td>
  <td class=xl75 width=60 style='border-top:none;width:45pt' x:num></td>
  <td class=xl76 width=53 style='border-top:none;width:40pt' x:num></td>
  <td class=xl76 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl76 width=53 style='border-top:none;width:40pt' x:num></td>
  <td class=xl76 width=0 style='border-top:none' x:num>2</td>
  <td class=xl77 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-top:none'>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
 </tr>  
 <%
 string school_code ="";
 string min_seq = "";
 string max_seq = "";
 double tt_size01 = 0, tt_size02 = 0, tt_size03 = 0, tt_size04 = 0, tt_size05 = 0, tt_size06 = 0, tt_size07 = 0, tt_school = 0, tt_box = 0;

 double ss_size01 = 0, ss_size02 = 0, ss_size03 = 0, ss_size04 = 0, ss_size05 = 0, ss_size06 = 0, ss_size07 = 0, ss_school = 0, ss_box = 0;
             
 for(int i=0;i<dt3.Rows.Count;i++)
 {            
 %>
 <% if ( school_code != dt3.Rows[i]["school_name"].ToString() && min_seq != dt3.Rows[i]["min_seq"].ToString() && i != 0 ) 
     { 
 %>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl181 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl207 style='border-left:none'>TOTAL:</td>
  <td colspan=3 class=xl204 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_box %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size01 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size02 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size03 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size04 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size05 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size06 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size07 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_school %></td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <% 
     ss_box = ss_box + tt_box;
     ss_size01 = ss_size01 + tt_size01;
     ss_size02 = ss_size02 + tt_size02;
     ss_size03 = ss_size03 + tt_size03;
     ss_size04 = ss_size04 + tt_size04;
     ss_size05 = ss_size05 + tt_size05;
     ss_size06 = ss_size06 + tt_size06;
     ss_size07 = ss_size07 + tt_size07;
     ss_school = ss_school + tt_school; 
        
     tt_box = 0;   
     tt_size01 = 0;
     tt_size02 = 0;
     tt_size03 = 0;
     tt_size04 = 0;
     tt_size05 = 0;
     tt_size06 = 0;
     tt_size07 = 0;   
     tt_school = 0;   
        } 
 %>

 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'></td>
  <td class=xl29>&nbsp;</td>
  <% if (i == 0)
     { %>
  
  <td class=xl175 style='border-top:none'><%=style_id %></td>
  <td class=xl176 style='border-top:none;border-left:none' x:num><%=po_no %></td>
  <%}
    else
    {
         %>
     <td class=xl175 style='border-top:none'></td>
  <td class=xl176 style='border-top:none;border-left:none' x:num></td>      
     <%} %>    
  <%    if (school_code != dt3.Rows[i]["school_name"].ToString())
        {
  %>
  <td class=xl177 style='border-left:none'><%=dt3.Rows[i]["school_name"]%></td>
  <td class=xl177 style='border-left:none' x:num><%=dt3.Rows[i]["sc"] %></td>
  <td class=xl177 style='border-left:none'><%=dt3.Rows[i]["licence_code"] %></td>
  <% 
        }
        else
        {
  %>
  <td class=xl177 style='border-left:none'></td>
  <td class=xl177 style='border-left:none' x:num></td>
  <td class=xl177 style='border-left:none'></td>
  <%    
        } 
        if (min_seq != dt3.Rows[i]["min_seq"].ToString() || max_seq != dt3.Rows[i]["max_seq"].ToString() )
        { 
  %>
  <td class=xl80 style='border-left:none' x:num><%=dt3.Rows[i]["min_seq"]%></td>
  <td class=xl81>~</td>
  <td class=xl82 x:num ><%=dt3.Rows[i]["max_seq"]%></td>
  <%    
        }
        else
        { 
  %>
  <td class=xl80 style='border-left:none' x:num></td>
  <td class=xl81>~</td>
  <td class=xl82 x:num ></td>   
  <%    
        }
  %>
  <td class=xl83 x:num><%=dt3.Rows[i]["box_qty"] %></td>
  <td class=xl84 x:num><%=dt3.Rows[i]["size1_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size2_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size3_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size4_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size5_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size6_qty"] %></td>
  <td class=xl85 style='border-left:none'><%=dt3.Rows[i]["size7_qty"] %></td>
  <td class=xl86 style='border-left:none' x:num ><%=dt3.Rows[i]["total_per_box"] %></td>
  <td class=xl86 x:num ><%=dt3.Rows[i]["total_qty"] %></td>
  <td class=xl141>&nbsp;</td>
 </tr>
        
        <%
     school_code = dt3.Rows[i]["school_name"].ToString();
     min_seq = dt3.Rows[i]["min_seq"].ToString();
     max_seq = dt3.Rows[i]["max_seq"].ToString();
     
     tt_box = tt_box + CommondLib.ConvertToDbl(dt3.Rows[i]["box_qty"]);
     tt_size01 = tt_size01 + CommondLib.ConvertToDbl(dt3.Rows[i]["size1_qty"]);
     tt_size02 = tt_size02 + CommondLib.ConvertToDbl(dt3.Rows[i]["size2_qty"]);
     tt_size03 = tt_size03 + CommondLib.ConvertToDbl(dt3.Rows[i]["size3_qty"]);
     tt_size04 = tt_size04 + CommondLib.ConvertToDbl(dt3.Rows[i]["size4_qty"]);
     tt_size05 = tt_size05 + CommondLib.ConvertToDbl(dt3.Rows[i]["size5_qty"]);
     tt_size06 = tt_size06 + CommondLib.ConvertToDbl(dt3.Rows[i]["size6_qty"]);
     tt_size07 = tt_size07 + CommondLib.ConvertToDbl(dt3.Rows[i]["size7_qty"]);
     tt_school = tt_school + CommondLib.ConvertToDbl(dt3.Rows[i]["total_qty"]); 
 }
  %> 
  <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl181 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl207 style='border-left:none'>TOTAL:</td>
  <td colspan=3 class=xl204 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_box %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size01 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size02 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size03 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size04 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_size05 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size06 %></td>
  <td class=xl107 style='border-top:none;border-left:none'><%=tt_size07 %></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num
  ><%=tt_school %></td>
  <td class=xl141>&nbsp;</td>
  <%     
     ss_box = ss_box + tt_box;
     ss_size01 = ss_size01 + tt_size01;
     ss_size02 = ss_size02 + tt_size02;
     ss_size03 = ss_size03 + tt_size03;
     ss_size04 = ss_size04 + tt_size04;
     ss_size05 = ss_size05 + tt_size05;
     ss_size06 = ss_size06 + tt_size06;
     ss_size07 = ss_size07 + tt_size07;
     ss_school = ss_school + tt_school;  
  %>
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
  <td class=xl114 style='border-top:none' x:num><%= ss_box%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size01%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size02%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size03%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size04%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size05%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size06%></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_size07%></td>
  <td class=xl114 style='border-top:none' x:num></td>
  <td class=xl114 style='border-top:none' x:num><%= ss_school%></td>
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
  <td colspan=16 class=xl188>SHIPMENT SUMMARY</td>
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
  <td class=xl167 style='border-top:none'>COTS1408H</td>
  <td class=xl170 align=right style='border-top:none;border-left:none' x:num>3992</td>
  <td class=xl167 style='border-top:none;border-left:none'>ALABAMA</td>
  <td class=xl173 align=right style='border-top:none;border-left:none' x:num>101</td>
  <td class=xl173 style='border-top:none;border-left:none'>CLC</td>
  <td colspan=3 class=xl185 style='border-right:.5pt solid black;border-left:
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
  <td class=xl94 style='border-top:none;border-left:none' x:num>73</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num>78</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num >78</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl198 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>APPLALAC ST</td>
  <td class=xl173 align=right style='border-top:none;border-left:none' x:num>102</td>
  <td class=xl173 style='border-top:none;border-left:none'>LRG</td>
  <td colspan=3 class=xl185 style='border-right:.5pt solid black;border-left:
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
  <td class=xl94 style='border-top:none;border-left:none' x:num>72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >76</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>20</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>20</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num >76</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl198 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>VIRG TECH</td>
  <td class=xl173 align=right style='border-top:none;border-left:none' x:num>382</td>
  <td class=xl173 style='border-top:none;border-left:none'>LRG</td>
  <td colspan=3 class=xl185 style='border-right:.5pt solid black;border-left:
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
  <td class=xl94 style='border-top:none;border-left:none' x:num>72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num >77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl198 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl167 style='border-top:none;border-left:none'>WISCONSIN</td>
  <td class=xl173 align=right style='border-top:none;border-left:none' x:num>393</td>
  <td class=xl173 style='border-top:none;border-left:none'>CLC</td>
  <td colspan=3 class=xl185 style='border-right:.5pt solid black;border-left:
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
  <td class=xl94 style='border-top:none;border-left:none' x:num>72</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl97 style='border-top:none;border-left:none' x:num>77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
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
  <td class=xl133 style='border-left:none' x:num >0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl171 style='border-left:none'>&nbsp;</td>
  <td class=xl168 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl189 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl134 style='border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>22</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl96 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133 style='border-left:none' x:num >77</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl169>&nbsp;</td>
  <td class=xl172 style='border-left:none'>&nbsp;</td>
  <td class=xl169 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td class=xl174 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl198 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl98 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=5 rowspan=5 class=xl213 style='border-right:.5pt solid black;
  border-bottom:1.0pt solid black'>G.TOTAL:</td>
  <td colspan=3 class=xl201 style='border-right:.5pt solid black;border-left:
  none'>ORDER Q'TY</td>
  <td class=xl137 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>39</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>57</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>78</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>73</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>42</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl138 style='border-top:none;border-left:none' x:num>289</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>1ST SHIPPED Q'TY</td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num>43</td>
  <td class=xl138 style='border-left:none' x:num>61</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>81</td>
  <td class=xl138 style='border-left:none' x:num>77</td>
  <td class=xl138 style='border-left:none' x:num>46</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>308</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>2nd SHIPPED Q'TY</td>
  <td class=xl135 style='border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl195 style='border-right:.5pt solid black;border-left:
  none'>TTL SHIPPED Q'TY</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num>43</td>
  <td class=xl138 style='border-left:none' x:num>61</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>81</td>
  <td class=xl138 style='border-left:none' x:num>77</td>
  <td class=xl138 style='border-left:none' x:num>46</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>308</td>
  <td class=xl141>&nbsp;</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl192 style='border-right:.5pt solid black;border-left:
  none'>BALANCE</td>
  <td class=xl139 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl138 style='border-left:none' x:num>4</td>
  <td class=xl138 style='border-left:none' x:num>4</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>3</td>
  <td class=xl138 style='border-left:none' x:num>4</td>
  <td class=xl138 style='border-left:none' x:num>4</td>
  <td class=xl138 style='border-left:none' x:num>0</td>
  <td class=xl138 style='border-left:none' x:num>19</td>
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
