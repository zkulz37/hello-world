<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    DataTable dt_mst, dt_dtl;
    string payment, etd, eta, poPK, sPODate, poid, sPOStaff, arrPK, amount, supplier, emp_name, deliver, currency, packing, bank, currency_rate, TotalInWord = "0";
	int fee, CurrencyRate, QTY, WEIGHT;
    double AMTUSD, TTAMT;

    AMTUSD = 0;
	QTY = 0;
    WEIGHT = 0;
    TTAMT = 0;
    
	payment  = Request["payment"];
	fee      = int.Parse(Request["fee"]);
	amount   = Request["amount"] ;
	etd      = Request["etd"] ;
	eta      = Request["eta"] ;
	poPK     = Request["PO_PK"];
	sPODate  = Request["poDate"];
	poid     = Request["poid"];
	sPOStaff = Request["StaffPO"];
    deliver  = Request["Deliver"];
    supplier = Request["supplier"];
    currency = Request["currency"];
    currency_rate = Request["CurrencyRate"];
    packing = Request["packing"];
	bank    = Request["Bank"];

    if (etd != "")
        etd = etd.Substring(5, 2).ToString() + "/" + etd.Substring(4, 2).ToString() + "/" + etd.Substring(0, 4).ToString();

    if (eta != "")
        eta = eta.Substring(5, 2).ToString() + "/" + eta.Substring(4, 2).ToString() + "/" + eta.Substring(0, 4).ToString();

    if (sPODate != "")
        sPODate = sPODate.Substring(5, 2).ToString() + "/" + sPODate.Substring(4, 2).ToString() + "/" + sPODate.Substring(0, 4).ToString();
	
	
	if (currency_rate == "")
		currency_rate = "0";
		
%>
<%
    dt_mst = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130", poPK);
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_30_1", poPK);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptOrderImport_files/filelist.xml">
<link rel=Edit-Time-Data href="rptOrderImport_files/editdata.mso">
<link rel=OLE-Object-Data href="rptOrderImport_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linkto</o:Author>
  <o:LastAuthor>user</o:LastAuthor>
  <o:LastPrinted>2007-09-07T09:27:40Z</o:LastPrinted>
  <o:Created>2007-06-18T05:44:28Z</o:Created>
  <o:LastSaved>2007-09-07T09:34:52Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .25in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:1.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:21.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style16;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl47
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
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
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
	white-space:normal;}
.xl62
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style16;}
.xl70
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:21.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl84
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
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
	white-space:normal;}
.xl91
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
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;}
.xl100
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:left;
	vertical-align:middle;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl103
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ORDER_Domestic</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$23:$D$23</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:TopRowVisible>18</x:TopRowVisible>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:TabRatio>846</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=911 style='border-collapse:
 collapse;table-layout:fixed;width:685pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=162 style='mso-width-source:userset;mso-width-alt:5924;
 width:122pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=62 span=244 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl26 colspan=3 width=216 style='height:20.25pt;
  mso-ignore:colspan;width:162pt'>POSCO E &amp; C - LILAMA</td>
  <td class=xl24 width=162 style='width:122pt'></td>
  <td class=xl24 width=47 style='width:35pt'></td>
  <td class=xl24 width=49 style='width:37pt'></td>
  <td class=xl24 width=58 style='width:44pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=86 style='width:65pt'></td>
  <td class=xl25 width=88 style='width:66pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Nhon
  Trach Zone Dong Nai Pro, Viet Nam</td>
  <td class=xl27></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tel:
  +84(613)560-659/8</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Fax:
  +84(613)560-852</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl30 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Contact
  Name: <%=sPOStaff%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl28></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td colspan=11 height=36 class=xl74 style='height:27.0pt'>PURCHASE ORDER</td>
  <td class=xl32></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'>Vendor:</td>
  <td colspan=2 rowspan=2 class=xl75 width=133 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:100pt'><%=supplier%></td>
  <td colspan=7 class=xl80 style='border-right:.5pt solid black;border-left:
  none'>PO No.</td>
  <td class=xl36 x:str="PO Date"><span style='mso-spacerun:yes'></span>PO
  Date<span style='mso-spacerun:yes'></span></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'>&nbsp;</td>
  <td colspan=7 class=xl83 style='border-right:.5pt solid black;border-left:
  none'><%=poid%></td>
  <td class=xl39><%=sPODate%></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=10 style='height:12.75pt;mso-ignore:colspan'
  x:str="We are pleased to place an order for the following described commodity ( ies ) on the term and conditions specified hereunder ">We
  are pleased to place an order for the following described commodity ( ies )
  on the term and conditions specified hereunder<span
  style='mso-spacerun:yes'></span></td>
  <td class=xl40></td>
  <td class=xl24></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=10 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl33 colspan=4 style='height:17.25pt;mso-ignore:colspan'>1.
  Description and specification : Origine</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=10 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl41 width=83 style='height:22.5pt;width:62pt'
  x:str="M/R No:  ">M/R No:<span style='mso-spacerun:yes'></span></td>
  <td colspan=3 class=xl85 width=295 style='border-right:.5pt solid black;
  width:222pt'><%=poid%></td>
  <td colspan=2 class=xl88 width=96 style='border-right:.5pt solid black;
  border-left:none;width:72pt' x:str="Project: ">Project:<span
  style='mso-spacerun:yes'></span></td>
  <td class=xl42 width=58 style='width:44pt'><%=dt_mst.Rows[0][0].ToString()%></td>
  <td class=xl43 colspan="4" ><%=dt_mst.Rows[0][1].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=9 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl45>Rate :</td>
  <td class=xl25 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=currency_rate%></td>
  <td class=xl24></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.6pt'>
  <td height=36 class=xl46 width=83 style='height:27.6pt;width:62pt'>SPEC.</td>
  <td colspan=3 class=xl91 width=295 style='border-right:.5pt solid black;
  border-left:none;width:222pt'>Iteam, Desc &amp; Material</td>
  <td class=xl47 width=47 style='width:35pt'>Unit</td>
  <td class=xl47 width=49 style='width:37pt'>Q'ty</td>
  <td class=xl47 width=58 style='width:44pt'>Weight (Kg)</td>
  <td class=xl48 width=72 style='width:54pt'>U.price (VND/kg)</td>
  <td class=xl47 width=79 style='width:59pt'>U.Price (VND/pcs)</td>
  <td class=xl49 width=86 style='width:65pt'>Amount (VND)</td>
  <td class=xl50 width=88 style='width:66pt'>Amount (USD)</td>
  <td class=xl24></td>
 </tr>
 
 <%
     if (dt_dtl.Rows.Count > 0)
     {
         for (int i = 0; i < dt_dtl.Rows.Count; i++)
         {
             if (double.Parse(currency_rate) > 0)
             {
                 AMTUSD = double.Parse(dt_dtl.Rows[i][7].ToString()) / double.Parse(currency_rate);
             }
         
             QTY    = QTY + int.Parse(dt_dtl.Rows[i][3].ToString());
             WEIGHT = WEIGHT + int.Parse(dt_dtl.Rows[i][4].ToString());
             TTAMT  = TTAMT + AMTUSD;
 %>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl51 width=83 style='height:16.9pt;width:62pt'><%=dt_dtl.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black;border-left:
  none'><%=dt_dtl.Rows[i][1].ToString() %></td>
  <td class=xl52><%=dt_dtl.Rows[i][2].ToString() %></td>
  <td class=xl54 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][3].ToString() %></td>
  <td class=xl54 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=dt_dtl.Rows[i][4].ToString() %></td>
  <td class=xl54 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][5].ToString() %></td>
  <td class=xl54 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][6].ToString() %></td>
  <td class=xl55 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][7].ToString() %></td>
  <td class=xl54 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=AMTUSD%></td>
  <td class=xl35></td>
 </tr>
 <%
         }
     }
 %>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl51 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl51 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl51 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr class=xl35 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl51 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl35></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl61 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl63 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl63 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl64 width=58 style='width:44pt'>&nbsp;</td>
  <td class=xl64 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl63 width=79 style='width:59pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl61 width=83 style='height:16.9pt;width:62pt'>&nbsp;</td>
  <td colspan=3 class=xl97 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl63 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl63 width=49 style='width:37pt'>&nbsp;</td>
  <td class=xl63 width=58 style='width:44pt'>&nbsp;</td>
  <td class=xl63 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl63 width=79 style='width:59pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td colspan=4 height=22 class=xl91 width=378 style='border-right:.5pt solid black;
  height:16.9pt;width:284pt'>GRAND TOTAL:</td>
  <td class=xl63 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl65 width=49 style='width:37pt' x:num><%=QTY %></td>
  <td class=xl65 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=WEIGHT %></td>
  <td class=xl62 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl63 width=79 style='width:59pt'>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl65 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=TTAMT %></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=2 style='height:15.75pt;mso-ignore:colspan'>2.
  Total order amount:</td>
  <td colspan=2 class=xl99 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=TTAMT %></td>
  <td class=xl24><%=currency %></td>
  <td class=xl67></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl35 style='height:15.75pt'>Total in word:</td>
  
  <%
      if (currency == "VND")
      {
   %>
  <td colspan=9 class=xl68><%=CommondLib.Num2VNText(Math.Round(TTAMT, 2).ToString(), currency)%></td>
  <%
      }
         else if (currency == "USD")
      {     
  %>
  <td colspan=9 class=xl68><%=CommondLib.Num2VNText(Math.Round(TTAMT, 2).ToString(), currency)%></td>
  <%
      }   
  %>
 
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="3.   Delivery: ">3.<span style='mso-spacerun:yes'>
  </span>Delivery:<span style='mso-spacerun:yes'></span></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'
  x:str="3.1 : Shipment date : ">3.1 : Shipment date :<span
  style='mso-spacerun:yes'></span></td>
  <td colspan=2 class=xl100></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>3.2 : Delivery place :</td>
  <td class=xl68><%=deliver%></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=3 style='height:15.75pt;mso-ignore:colspan'>4.
  Term and Conditions:</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl68 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="     4.1. Payment: "><span style='mso-spacerun:yes'> </span>4.1.
  Payment:<span style='mso-spacerun:yes'></span></td>
  <td colspan=8 style='mso-ignore:colspan'>100% total amount shall be paid by
  T/T after receipt of all orgin shipping document &amp; material 30 days</td>
  <td class=xl69></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl68 colspan=2 style='height:15.75pt;mso-ignore:colspan' x:str="     4.2. Packing: "><span
  style='mso-spacerun:yes'> </span>4.2. Packing:</td>
  <td class=xl24><%=packing%>&nbsp;</td>
  <td colspan=2 class=xl24></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl68 colspan=3 style='height:15.75pt;mso-ignore:colspan' x:str="     4.3. The Buyer's bank: "><span
  style='mso-spacerun:yes'> </span>4.3. The Buyer's bank:</td>
  <td colspan=2 class=xl24><%=bank%>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl101 style='height:15.75pt'>5.<span
  style='mso-spacerun:yes'> </span>Insurance:</td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>All risks shall be
  covered by the Buyer</td>
  <td class=xl35></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=5 style='height:15.75pt;mso-ignore:colspan'>6.<span
  style='mso-spacerun:yes'> </span> Transportation: Company name :  KCTC CO.,LTD
  </td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl103 style='height:15.75pt'>
  ADDRESS : 16th FL, HAN JIN BLDG. #118, 2-KA,NAMDAEMUN-RO,CHUNG-KU, SEOUL, KOREA - POST CODE : 110-092
  </td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>1.) MR.KIM MYOUNG SOO</td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>2.) MR.KIM DONG GOO ( Affiliated Company : Bulk shipping Line)</td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>TEL:  +82-2-752-4404</td>
  <td class=xl35></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>TEL:  +82-2-738-4505</td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>FAX: +82-2-752-4404</td>
  <td class=xl35></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>FAX: +82-2-738-4507</td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=3 >E-MAIL: <span style='text-decoration:underline;text-underline-style:single;'>mskim@kctc.co.kr</span></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>MOBILE: +82-17-355-8592</td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl71 colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl71 colspan=4 >E-MAIL: <span style='text-decoration:underline;text-underline-style:single;'>dgkim@woohyunshpg.co.kr</span></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=2 style='height:15.75pt;mso-ignore:colspan'>7.<span
  style='mso-spacerun:yes'> </span>Special note:</td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl33></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=8 style='mso-ignore:colspan'>a. Heat No. have to be on the plate based on the Mill sheet (EN10204 TYPE 3.1)</td>
  <td class=xl35></td>
  <td class=xl70></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=9 style='mso-ignore:colspan'>b. Suppliers shall submit
  to Poslilama the orginal shipping docs in triplicate C/O &amp; Mill sheet</td>
  <td class=xl72></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=7 style='mso-ignore:colspan'>The Seller shall make
  shipping mark as descibled hereubder, unless otherwise instructed by
  Poslilama :</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl35 colspan=9 style='mso-ignore:colspan'>Poslilama-Ho Chi Minh /
  PO No./Commdify Desc./ Dimension / Gross Weight.</td>
  <td class=xl72></td>
  <td class=xl35></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'>c. 0.015% of total PO
  amount per day shall be calculated as delay penlty from <%=etd%> for the
  material in this PO</td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Confirm
  and accepted by Supplier</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl102>Issued by Posco E & C - Lilama</td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl38 style='height:16.9pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl79>Park Si Sung</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=8 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl102>General Director</td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=83 style='width:62pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=162 style='width:122pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=54 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>